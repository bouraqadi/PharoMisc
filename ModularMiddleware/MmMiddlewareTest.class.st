Class {
	#name : #MmMiddlewareTest,
	#superclass : #TestCase,
	#instVars : [
		'middleware'
	],
	#category : #'ModularMiddleware-Tests'
}

{ #category : #tests }
MmMiddlewareTest >> assert: proxy isProxyOf: exportedObject [
	self deny: proxy == exportedObject.
	self assert: (proxy isKindOf: MmProxy)
]

{ #category : #tests }
MmMiddlewareTest >> assertMessageResult: expectedResult [
	| proxy |
	proxy := self proxyForValueHolderWithContents: expectedResult.
	self assert: proxy contents equals: expectedResult
]

{ #category : #running }
MmMiddlewareTest >> middlewareClass [
	^ MmLocalMiddleware
]

{ #category : #tests }
MmMiddlewareTest >> proxyForValueHolderWithContents: anObject [
	| exportedObject id |
	id := #myObject.
	exportedObject := ValueHolder new.
	exportedObject contents: anObject.
	middleware export: exportedObject id: id.
	^ middleware proxyWithId: id
]

{ #category : #running }
MmMiddlewareTest >> setUp [
	super setUp.
	middleware := self middlewareClass new.

]

{ #category : #tests }
MmMiddlewareTest >> testProxyCreation [
	| id exportedObject proxy |
	id := #myObject.
	exportedObject := Object new.
	middleware export: exportedObject id: id.
	proxy := middleware proxyWithId: id.
	self assert: proxy isProxyOf: exportedObject
]

{ #category : #tests }
MmMiddlewareTest >> testRemoteMessageWithBlockArgument [
	| result id exportedArray proxy |
	id := #myArray.
	exportedArray := #('Hello World' #Pharo #Middleware).
	middleware export: exportedArray id: id.
	proxy := middleware proxyWithId: id.
	result := proxy collect: [ :each | each size ].
	self assert: result first equals: exportedArray first size.
	self assert: result last equals: exportedArray last size
]

{ #category : #tests }
MmMiddlewareTest >> testRemoteMessageWithException [
	| proxy |
	proxy := self proxyForValueHolderWithContents: #().
	self should: [proxy foo] raise: MmRemoteException
]

{ #category : #tests }
MmMiddlewareTest >> testRemoteMessageWithPassByCopyResults [
	{'Hello Pharo'. 958. 3.14. true. nil} do: [ : expectedResult |
		 self assertMessageResult: expectedResult]
	
	
]

{ #category : #tests }
MmMiddlewareTest >> testRemoteMessageWithPassByReferenceResult [
	| proxy actualObject |
	actualObject := #('Hello World' #Pharo #Middleware).
	proxy := self proxyForValueHolderWithContents: actualObject.
	self assert: proxy contents isProxyOf: actualObject.
	

]
