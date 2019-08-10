Class {
	#name : #SmThreeMiddlewareTest,
	#superclass : #TestCase,
	#instVars : [
		'middlewares',
		'middleware1',
		'middleware2',
		'middleware3'
	],
	#category : #'SimpleMiddleware-Test'
}

{ #category : #testing }
SmThreeMiddlewareTest >> setUp [
	super setUp.
	middlewares := OrderedCollection new.
	1 to: 3 do: [: index |  
		middlewares add: (SmMiddleware port: index * 11111) ].
	middlewares do: [ :  each | each start].
	middleware1 := middlewares first.
	middleware2 := middlewares second.
	middleware3 := middlewares third.
]

{ #category : #testing }
SmThreeMiddlewareTest >> tearDown [
	super tearDown.
	middlewares do: [ :  each | each stop].
]

{ #category : #testing }
SmThreeMiddlewareTest >> testSendingProxyOfRemoteObjectAsParameter [
	| interval proxyInterval orderedCol proxyOrderedCol proxyIntervalBis |
	interval := 1 to: 5.
	middleware1 export: interval as: #interval.	
	proxyInterval := middleware2 proxyIp: middleware1 ip port: middleware1 port identifier: #interval.
	self assert: (proxyInterval isKindOf: SmProxy).

	orderedCol := OrderedCollection new.
	middleware3 export: orderedCol as: #orderedCol.
	proxyOrderedCol := middleware2 proxyIp: middleware3 ip port: middleware3 port identifier: #orderedCol.
	self assert: (proxyOrderedCol isKindOf: SmProxy).
	
	proxyOrderedCol add: proxyInterval.
	proxyIntervalBis := orderedCol first.
	self deny: proxyIntervalBis == proxyInterval.
	
	self assert: proxyIntervalBis last equals: 5.
	
]
