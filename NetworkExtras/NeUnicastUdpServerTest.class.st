Class {
	#name : #NeUnicastUdpServerTest,
	#superclass : #NeUdpServerTest,
	#category : #'NetworkExtras-Test'
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

{ #category : #testing }
NeUnicastUdpServerTest >> testDefaultReceptionHandlingAction [

	| allSentStrings expectedString |
	Transcript clear.
	allSentStrings := #( 'Hello' 'World' 'Pharo' ).
	allSentStrings do: [ :sentString | 
		server defaultReceptionHandlingBlock value: sentString asByteArray.
	].
	expectedString := String streamContents: [ : str | 
		allSentStrings do: [ : each |
			str << each;
			cr ]
	].
self
			waitUntil: [ Transcript contents = expectedString ]
			timeout: 2 seconds
]
