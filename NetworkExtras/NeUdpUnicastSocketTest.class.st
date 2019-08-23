Class {
	#name : #NeUdpUnicastSocketTest,
	#superclass : #NeUdpSocketTest,
	#traits : 'TWaitPolling',
	#classTraits : 'TWaitPolling classTrait',
	#instVars : [
		'port',
		'receiver',
		'sender'
	],
	#category : #'NetworkExtras-Test'
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
	self waitUntil: [ done ] timeout: 1100 milliSeconds. "Add 100 millis to take into account context switching"
	self deny: errorSignaled.
]

{ #category : #testing }
NeUdpUnicastSocketTest >> testForbideMultipleSocketsListeningOnTheSamePort [
	| socketCreationBlocks |
	socketCreationBlocks := {[NeUnicastUdpSocket listenOn: port].
		[NeUdpSocket new listenOn: port; yourself].
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
	self waitUntil: [ timeoutSignaled ] timeout: 1100 milliSeconds. "Add 100 millis to take into account context switching"

]

{ #category : #testing }
NeUdpUnicastSocketTest >> testUnicastSendReceive [
	sender send: 'Hello'.
	self assert: (receiver receiveTimeout: 1) asString equals: 'Hello'
]
