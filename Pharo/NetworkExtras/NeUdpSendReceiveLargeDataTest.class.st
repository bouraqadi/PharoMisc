Class {
	#name : #NeUdpSendReceiveLargeDataTest,
	#superclass : #TestCase,
	#traits : 'CcTWaitPolling + NeTLargeDataProviderForTest',
	#classTraits : 'CcTWaitPolling classTrait + NeTLargeDataProviderForTest classTrait',
	#instVars : [
		'receiver',
		'targetPort',
		'allSenders'
	],
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> newSender [
	| newSender |
	newSender := NeUdpLargeDataSender target: self targetIp port: self targetPort.
	allSenders add: newSender.
	^newSender
]

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> setUp [
	super setUp.
	targetPort := NeUdpUsedPortsTracker freePortAtRandom.
	allSenders := Set new.
	self setUpReceiver.
]

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> setUpReceiver [
	receiver := NeUdpLargeDataReceiver unicastPort: self targetPort.
	receiver priority: Processor userSchedulingPriority.
	receiver start.

]

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> targetIp [
	^ #[127 0 0 1]
]

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> targetPort [
	^targetPort
]

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> tearDown [
	super tearDown.
	allSenders do: [ :each | each destroySocket].
	receiver stop

]

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> test1Sender1Receiver [

	| receivedData sentString sender senderId |
	receiver withReceivedDataDo: [ :id :data | 
		senderId := id.
		receivedData := data ].
	sender := self newSender.
	sentString := self get100KBytesOfSourceFile.
	[ sender send: sentString ] forkAt: Processor userBackgroundPriority.
	self waitWhile: [ receivedData isNil ] timeout: 500 milliSeconds.
	self assert: receivedData equals: sentString asByteArray.
	self assert: senderId equals: sender id
]

{ #category : #testing }
NeUdpSendReceiveLargeDataTest >> test2Senders1Receiver [
	| receivedDataSet sentData1 sentData2 sender1 sender2 |
	sender1 := self newSender.
	sender1 id: #sender1.
	sender2 := self newSender.
	sender2 id: #sender2.
	receivedDataSet := Set new.
	receiver withReceivedDataDo: [ : id :data | receivedDataSet add: {id. data} ].
	sentData1 := self get100KBytesOfSourceFile asByteArray.
	sentData2 := self get5KBytesOfSourceFile asByteArray.
	[ sender1 send: sentData1 ] forkAt: Processor userBackgroundPriority.
	[ sender2 send: sentData2 ] forkAt: Processor userInterruptPriority.
	self waitWhile: [ receivedDataSet size < 2 ] timeout: 500 milliSeconds.
	self
		assert: receivedDataSet
		equals:
			{
			{sender1 id. sentData1}.
			{sender2 id. sentData2}} asSet
]
