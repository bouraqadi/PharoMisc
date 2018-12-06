Class {
	#name : #NeUdpUnicastSocketTest,
	#superclass : #NeUdpSocketTest,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#instVars : [
		'port',
		'receiver',
		'sender'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeUdpUnicastSocketTest >> setUp [
	super setUp.
	port := NeUdpUsedPortsTracker freePortAtRandom.
	receiver := self newUnicastUdpSocketReceivingOnPort: port.
	sender := self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: port.

]

{ #category : #testing }
NeUdpUnicastSocketTest >> tearDown [
	super tearDown.
	sender closeAndDestroy.
	receiver closeAndDestroy
]

{ #category : #testing }
NeUdpUnicastSocketTest >> testCloseWhileReceiving [
	| done errorSignaled |
	done := false.
	errorSignaled := false.
	[ 
		[ [receiver receiveTimeout: 1] ensure: [ done := true ] ] on: Error do: [errorSignaled := true]. 
	] forkAt: Processor userInterruptPriority.
	sender send: 'some data'.	
	receiver closeAndDestroy.
	self waitUntil: [ done ] timeout: 1 second.
	self deny: errorSignaled.
]

{ #category : #testing }
NeUdpUnicastSocketTest >> testForbideMultipleSocketsListeningOnTheSamePort [
	| socketCreationBlocks |
	socketCreationBlocks := {[NeUdpSocket receptionPort: port].
		[NeUdpSocket new receptionPort: port; yourself].
		[NeUdpSocket new setPort: port; yourself].
	}.
	socketCreationBlocks do: [ : creationBlock | 
			self should: [self createSocket: creationBlock] raise: NeAlreadyUsedSocketPort.
	].
	receiver closeAndDestroy.
	socketCreationBlocks do: [ : each | 
		|newSocket|
		self shouldnt: [newSocket := each value] raise: NeAlreadyUsedSocketPort.
		newSocket closeAndDestroy.
	].

]

{ #category : #testing }
NeUdpUnicastSocketTest >> testReceiveSend [
	| sentData receivedData |
	sentData := 'Hello World!'.
	[self shouldnt: [receivedData := receiver receiveTimeout: 1] raise: Error] forkAt: Processor userInterruptPriority.
	sender send: sentData.	
	self waitWhile: [ receivedData isNil ].
	self assert: receivedData asString equals: sentData.
]

{ #category : #testing }
NeUdpUnicastSocketTest >> testReceiveTimeout [
	| timeoutSignaled |
	timeoutSignaled := false.
	[ 
		[ receiver receiveTimeout: 1 ] on: ConnectionTimedOut do: [timeoutSignaled := true]. 
	] forkAt: Processor userInterruptPriority.
	self waitUntil: [ timeoutSignaled ] timeout: 1 second.

]

{ #category : #testing }
NeUdpUnicastSocketTest >> testUnicastSendReceive [
	sender send: 'Hello'.
	self assert: (receiver receiveTimeout: 1) asString equals: 'Hello'
]
