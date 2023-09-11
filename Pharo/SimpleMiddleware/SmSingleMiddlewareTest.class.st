Class {
	#name : #SmSingleMiddlewareTest,
	#superclass : #TestCase,
	#instVars : [
		'middleware'
	],
	#category : #'SimpleMiddleware-Test'
}

{ #category : #testing }
SmSingleMiddlewareTest >> setUp [
	super setUp.
	middleware := SmMiddleware new.
]

{ #category : #testing }
SmSingleMiddlewareTest >> tearDown [
	super tearDown.
	middleware stop.
]

{ #category : #testing }
SmSingleMiddlewareTest >> testCommunication [
	| proxy result id |
	middleware start.
	id := #myObject.
	middleware export: #(1 2 3) as: id.
	proxy := middleware proxyIp: middleware ip port: middleware port identifier: id.
	self assert: (proxy isKindOf: SmProxy).
	self assert: proxy first equals: 1.
	self assert: proxy second equals: 2.
	result := proxy collect: [ :each | each * 2 ].
	self assert: result first equals: 2.
	self assert: result last equals: 6
]

{ #category : #testing }
SmSingleMiddlewareTest >> testDefaultIp [
	self assert: middleware ip equals: '127.0.0.1'.
]

{ #category : #testing }
SmSingleMiddlewareTest >> testStartStop [
	self deny: middleware isStarted.
	middleware start.
	self assert: middleware isStarted.
	middleware stop.
	self deny: middleware isStarted.
	
]
