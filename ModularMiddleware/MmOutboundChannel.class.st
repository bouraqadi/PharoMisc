Class {
	#name : #MmOutboundChannel,
	#superclass : #MmChannel,
	#instVars : [
		'promisesDict'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmOutboundChannel class >> middleware: aMiddleware address: anAddress [
	^(self middleware: aMiddleware)
		address: anAddress;
		yourself
]

{ #category : #initialization }
MmOutboundChannel >> address: anAddress [
	self subclassResponsibility
]

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
MmOutboundChannel >> send: aMessage receiverId: receiverId [
	| promise resultId result semaphore |
	resultId := self newResultId.
	promise := CcPromise
		onFulfillDo: [: answer | 
			result := answer.
			semaphore signal.] 
		onRejectDo: [: exception | 
			result := [exception signal].
			semaphore signal.].
	promisesDict at: resultId put: promise.
	semaphore := Semaphore new.		
	self send: aMessage receiverId: receiverId resultId: resultId.
	semaphore wait.
	^ result value
]

{ #category : #sending }
MmOutboundChannel >> send: aMessage receiverId: receiverId resultId: resultId [
	| remoteMessage |
	remoteMessage := MmRemoteMessage
		selector: aMessage selector
		arguments: aMessage arguments
		receiverId: receiverId 
		resultId: resultId.
	self sendObject: remoteMessage
]
