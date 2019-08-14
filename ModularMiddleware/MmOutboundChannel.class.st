Class {
	#name : #MmOutboundChannel,
	#superclass : #MmChannel,
	#instVars : [
		'futuresDict'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #sending }
MmOutboundChannel >> futureClass [
	^CcFuture
]

{ #category : #initialization }
MmOutboundChannel >> initialize [
	super initialize.
	futuresDict := WeakValueDictionary new
]

{ #category : #sending }
MmOutboundChannel >> newFutureForResultId: resultId [
	^futuresDict at: resultId put: self futureClass new
]

{ #category : #sending }
MmOutboundChannel >> newResultId [
	^UUID new
]

{ #category : #sending }
MmOutboundChannel >> receiveObject: remoteResult [
	| future |
	future := futuresDict at: remoteResult id ifAbsent: [^self].
	future value: remoteResult actualValue
]

{ #category : #sending }
MmOutboundChannel >> send: aMessage receiverId: receiverId [
	| future resultId |
	resultId := self newResultId.
	future := self newFutureForResultId: resultId.
	self send: aMessage receiverId: receiverId resultId: resultId.
	^ future
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
