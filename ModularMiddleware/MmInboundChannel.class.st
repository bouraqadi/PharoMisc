Class {
	#name : #MmInboundChannel,
	#superclass : #MmChannel,
	#instVars : [
		'exportedObjectsDict'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #accessing }
MmInboundChannel >> exportedObjectsDict: aDictionary [
	exportedObjectsDict := aDictionary
]

{ #category : #accessing }
MmInboundChannel >> objectAt: id [
	^exportedObjectsDict at: id
]

{ #category : #receiving }
MmInboundChannel >> receiveObject: remoteMessage [
	| receiver result remoteResult |
	receiver := self objectAt: remoteMessage receiverId.
	result := remoteMessage sendTo: receiver.
	remoteResult := MmRemoteResult id: remoteMessage resultId value: result.
	self sendObject: remoteResult
]
