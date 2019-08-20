Class {
	#name : #MmOutboundChannel,
	#superclass : #MmChannel,
	#instVars : [
		'promisesDict'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #initialization }
MmOutboundChannel >> initialize [
	super initialize.
	promisesDict := WeakValueDictionary new
]

{ #category : #sending }
MmOutboundChannel >> newResultId [
	^UUID new
]

{ #category : #sending }
MmOutboundChannel >> receiveObject: remoteResponse [
	| promise |
	promise := promisesDict at: remoteResponse id ifAbsent: [^self].
	remoteResponse trigger: promise

]

{ #category : #sending }
MmOutboundChannel >> send: aMessage to: receiver [
	| promise resultId result semaphore |
	resultId := self newResultId.
	semaphore := Semaphore new.		
	promise := CcPromise
		onFulfillDo: [: answer | 
			result := answer.
			semaphore signal] 
		onRejectDo: [: exception | 
			result := [exception signal].
			semaphore signal].
	promisesDict at: resultId put: promise.
	self send: aMessage to: receiver resultId: resultId.
	semaphore wait.
	^ result value
]

{ #category : #sending }
MmOutboundChannel >> send: aMessage to: receiver resultId: resultId [
	| remoteMessage |
	remoteMessage := MmRemoteMessage
		selector: aMessage selector
		arguments: aMessage arguments
		receiver: receiver 
		resultId: resultId.
	self sendObject: remoteMessage
]
