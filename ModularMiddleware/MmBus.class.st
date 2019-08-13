Class {
	#name : #MmBus,
	#superclass : #Object,
	#instVars : [
		'isStarted'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #communicating }
MmBus >> futureClass [
	^CcFuture
]

{ #category : #'initialize-release' }
MmBus >> initialize [
	super initialize.
	self isStarted: false
]

{ #category : #activity }
MmBus >> isStarted [
	^isStarted
]

{ #category : #activity }
MmBus >> isStarted: aBoolean [
	isStarted := aBoolean
]

{ #category : #activity }
MmBus >> isStopped [
	^self isStarted not
]

{ #category : #communicating }
MmBus >> newMessageId [
	^UUID new
]

{ #category : #activity }
MmBus >> onStartDo: aBlockClosure [ 
	aBlockClosure value
]

{ #category : #activity }
MmBus >> onStopDo: aBlockClosure [ 
	aBlockClosure value
]

{ #category : #communicating }
MmBus >> send: aMessage receiverId: receiverId address: anAddress [
	| future messageId |
	future := self futureClass new.
	messageId := self newMessageId.
	self send: aMessage receiverId: receiverId address: anAddress messageId: messageId.
	^future
]

{ #category : #communicating }
MmBus >> send: aMessage receiverId: id address: anAddress messageId: messageId [
	^self
]

{ #category : #activity }
MmBus >> start [
	self isStarted: true
]

{ #category : #activity }
MmBus >> stop [
	self isStarted: false
]
