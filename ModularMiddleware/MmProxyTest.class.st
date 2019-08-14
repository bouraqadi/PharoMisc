Class {
	#name : #MmProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'middleware',
		'proxy',
		'exportedObject'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #running }
MmProxyTest >> setUp [
	| id |
	super setUp.
	middleware := MmLocalMiddleware new.
	id := #myObject.
	exportedObject := #(1 2 3).
	middleware export: exportedObject as: id.
	proxy := middleware proxyId: id address: middleware address.

]

{ #category : #tests }
MmProxyTest >> testProxyCommunication [
	| result |
	self assert: proxy first equals: 1.
	self assert: proxy second equals: 2.
	result := proxy collect: [ :each | each * 2 ].
	self assert: result first equals: 2.
	self assert: result last equals: 6
]

{ #category : #tests }
MmProxyTest >> testProxyCreation [
	self deny: proxy == exportedObject.
	self assert: (proxy isKindOf: MmProxy).

]
