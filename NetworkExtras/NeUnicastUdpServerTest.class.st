Class {
	#name : #NeUnicastUdpServerTest,
	#superclass : #NeUdpServerTest,
	#category : #'NetworkExtras-KernelTest'
}

{ #category : #testing }
NeUnicastUdpServerTest >> newServer [
	^ NeUnicastUdpServer port: NeUdpUsedPortsTracker freePortAtRandom
]

{ #category : #testing }
NeUnicastUdpServerTest >> setUp [
	super setUp.
	sender := self newUnicastUdpSocketEmittingToIp: 'localhost' port:  server port.

	
]

{ #category : #testing }
NeUnicastUdpServerTest >> startServer [
	server start
]

{ #category : #testing }
NeUnicastUdpServerTest >> stopServer [
	server stop
]

{ #category : #testing }
NeUnicastUdpServerTest >> testBroadcastSendReceive [
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
