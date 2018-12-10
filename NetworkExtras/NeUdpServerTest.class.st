Class {
	#name : #NeUdpServerTest,
	#superclass : #NeUdpSocketTest,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#instVars : [
		'server',
		'sender',
		'allReceivedData'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeUdpServerTest >> setUp [
	super setUp.
	allReceivedData := OrderedCollection new.
	server := NeUdpServer receptionPort: NeUdpUsedPortsTracker freePortAtRandom.
	server onReceptionDo: [ :data | allReceivedData add: data asString ].
	server priority: Processor userInterruptPriority.

]

{ #category : #testing }
NeUdpServerTest >> tearDown [
	super tearDown.
	server stop
]

{ #category : #testing }
NeUdpServerTest >> testBroadcastSendReceive [
	| allSentData |
	allSentData := #('Hello' 'World' 'Pharo').
	server start.
	sender := self newBroadcastSocketOnPort: server port.
	allSentData withIndexDo: [ :each :index | 
		sender send: each.
		self waitUntil: [ allReceivedData size = index ].
	].
	self assert: allReceivedData asArray equals: allSentData
]

{ #category : #testing }
NeUdpServerTest >> testMulticastSendReceive [
	| allSentData multicastGroup multicastPort serverSocket |
	multicastGroup := '236.1.2.13'.
	multicastPort := NeUsedPortsTracker freePortAtRandom.
	server socket closeAndDestroy. "Cleanly remove it and ensure port is free"
	serverSocket := self createSocket: [
		NeMulticastSocket group: multicastGroup port: multicastPort].
	server socket: serverSocket.
	server socket unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	"Order is important! Since we are on the same machine and use the default interface, 
	receiver socket should be created first to ensure it will be fed packets by the OS. 
	Remeber that sockets are bidirectional."
	sender := self createSocket: [NeMulticastSocket group: multicastGroup port: multicastPort].
	server start.
	allSentData := #('Hello' 'World' 'Pharo').
	allSentData withIndexDo: [ :each :index | 
		sender send: each.
		self waitUntil: [ allReceivedData size = index ].
	].
	self assert: allReceivedData asArray equals: allSentData
]

{ #category : #testing }
NeUdpServerTest >> testStopShouldQuicklyReturn [
	server start.
	self should: [ server stop ] notTakeMoreThan: 500 milliSeconds 
]

{ #category : #testing }
NeUdpServerTest >> testUnicastSendReceive [
	| allSentData |
	allSentData := #('Hello' 'World' 'Pharo').
	server start.
	sender := self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: server port.
	allSentData withIndexDo: [ :each :index | 
		sender send: each.
		self waitUntil: [ allReceivedData size = index ].
	].
	self assert: allReceivedData asArray equals: allSentData
]
