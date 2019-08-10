Class {
	#name : #SmMarshallerTest,
	#superclass : #TestCase,
	#instVars : [
		'marshaller',
		'dispatcher'
	],
	#category : #'SimpleMiddleware-Test'
}

{ #category : #testing }
SmMarshallerTest >> setUp [
	super setUp.
	marshaller := SmMiddleware new marshaller.
	dispatcher := marshaller dispatcher.
]

{ #category : #testing }
SmMarshallerTest >> testDuplicationOfProxiesOfSameIdButDifferentIpsOrPorts [
	| proxy1 proxy2  proxy3|
	proxy1 := marshaller proxyIp: 'ipA' port: 123 identifier: #id.
	proxy2 := marshaller proxyIp: 'ipB' port: 123 identifier: #id.
	proxy3 := marshaller proxyIp: 'ipA' port: 456 identifier: #id.
	self deny: proxy1 == proxy2.	
	self deny: proxy3 == proxy2.	 
	self deny: proxy1 == proxy3.	  
]

{ #category : #testing }
SmMarshallerTest >> testMarshallingBasicObjects [
	{ nil. 1. true. false. 'hello'. $a. #symbol.} do: [ : each |
		self assert: (marshaller marshall: each) == each ].
	
]

{ #category : #testing }
SmMarshallerTest >> testMarshallingPlainObject [
	| result |
	result := marshaller marshall: Object new.
	self assert: (result class == SmRemoteReference).
	
]

{ #category : #testing }
SmMarshallerTest >> testMarshallingProxy [
	| result proxy |
	proxy := SmProxy new.
	result := marshaller marshall: proxy.
	self assert: (result class == SmRemoteReference).
	self assert: result ip equals: (proxy instVarNamed: #ip).
	self assert: result port equals: (proxy instVarNamed: #port).
	self assert: result identifier equals: (proxy instVarNamed: #identifier).
	
]

{ #category : #testing }
SmMarshallerTest >> testMarshallingRemoteMessage [
	| result message |
	message := SmRemoteMessage receiverId: 'abc' selector: #with:with: arguments: { SmProxy new. Object new}.
	result := marshaller marshall: message.
	self assert: result == message.
	message arguments do: [ : each |
		self assert: (each class == SmRemoteReference)].
	
]

{ #category : #testing }
SmMarshallerTest >> testMultipleUnmarshallingOfProxyOfRemoteObject [
	| remoteRef result1 result2 |
	remoteRef := SmRemoteReference ip: 'differentIp' port: 1234 identifier: 'aaa'.
	result1 := marshaller unmarshall: remoteRef.
	result2 := marshaller unmarshall: remoteRef.
	self assert: result1 == result2.
]

{ #category : #testing }
SmMarshallerTest >> testNoDuplicationOfProxies [
	| proxy1 proxy2  ip port id |
	ip := 'someIp'.
	port := 12345.
	id := #anyId.
	proxy1 := marshaller proxyIp: ip port: port identifier: id.
	proxy2 := marshaller proxyIp: ip port: port identifier: id.
	self assert: proxy1 == proxy2.	 
]

{ #category : #testing }
SmMarshallerTest >> testUnmarshallingBasicObjects [
	{ nil. 1. true. false. 'hello'. $a. #symbol.} do: [ : each |
		self assert: (marshaller unmarshall: each) == each ].
		
]

{ #category : #testing }
SmMarshallerTest >> testUnmarshallingProxiesOfLocalObjects [
	| id object proxy remoteRef result |
	id := #someObject.
	object := Object new.
	dispatcher export: object as: id.
	proxy := marshaller newProxyIp: marshaller ip port: marshaller port identifier: id. 
	remoteRef := marshaller marshall: proxy.
	result := marshaller unmarshall: remoteRef.
	self assert: result == object.
		
]

{ #category : #testing }
SmMarshallerTest >> testUnmarshallingProxiesOfRemoteObjects [
	| differentIp differentPort result |
	differentIp := 'someIp'.
	differentPort := marshaller port + 3.
	{
		SmRemoteReference ip: differentIp port: differentPort identifier: 'aaa'.
		SmRemoteReference ip: marshaller ip port: differentPort identifier: 'bbb'.
		SmRemoteReference ip: differentIp port: marshaller port identifier: 'ccc'.
	} do: [ : each |
		result := marshaller unmarshall: each.
		self assert: (result isKindOf: SmProxy).
		self assert: (result instVarNamed: #ip) equals: (each instVarNamed: #ip).
		self assert: (result instVarNamed: #port) equals: (each instVarNamed: #port).
		self assert: (result instVarNamed: #identifier) equals: (each instVarNamed: #identifier).
		self assert: (result instVarNamed: #protocol) == marshaller protocol.
	].
		
]

{ #category : #testing }
SmMarshallerTest >> testUnmarshallingRemoteMessage [
	| result message object proxy |
	object := Object new.
	dispatcher export: object as: #someObject.
	proxy := marshaller newProxyIp: 'someIp' port: marshaller port + 5 identifier: #someObject.
	message := SmRemoteMessage receiverId: 'abc' selector: #with:with: arguments: {object. proxy}.
	result := marshaller unmarshall: (marshaller marshall: message).
	self assert: result == message.
	self assert: message arguments first == object.
	self assert: (message arguments second isKindOf: SmProxy).
	
]
