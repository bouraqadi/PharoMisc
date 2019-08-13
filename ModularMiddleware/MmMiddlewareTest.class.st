Class {
	#name : #MmMiddlewareTest,
	#superclass : #TestCase,
	#instVars : [
		'middleware'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #running }
MmMiddlewareTest >> setUp [
	super setUp.
	middleware := MmMiddleware new
]

{ #category : #tests }
MmMiddlewareTest >> testProxy [
	| proxy result exportedObject id |
	middleware start.
	id := #myObject.
	exportedObject := #(1 2 3).
	middleware export: exportedObject as: id.
	proxy := middleware proxyId: id address: middleware address.
	self deny: proxy == exportedObject.
	self assert: (proxy isKindOf: MmProxy).
	self assert: proxy first equals: 1.
	self assert: proxy second equals: 2.
	result := proxy collect: [ :each | each * 2 ].
	self assert: result first equals: 2.
	self assert: result last equals: 6
]

{ #category : #tests }
MmMiddlewareTest >> testStart [
	| startSemaphore |
	self deny: middleware isStarted.
	self assert: middleware isStopped.
	startSemaphore := Semaphore new.
	middleware onStartDo: [ startSemaphore signal ].
	middleware start.
	startSemaphore wait.
	self assert: middleware isStarted.
	self deny: middleware isStopped.

]

{ #category : #tests }
MmMiddlewareTest >> testStop [
	| stopSemaphore |
	stopSemaphore := Semaphore new.
	middleware onStopDo: [ stopSemaphore signal ].
	middleware start.
	middleware stop.
	stopSemaphore wait.
	self assert: middleware isStopped.
	self deny: middleware isStarted

]
