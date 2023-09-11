Class {
	#name : #NeTcpServerTest,
	#superclass : #NeTcpSocketTest,
	#traits : 'CcTWaitPolling',
	#classTraits : 'CcTWaitPolling classTrait',
	#instVars : [
		'server',
		'allServers'
	],
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTcpServerTest >> newClientStream [
	| newClient |
	newClient := ZdcSocketStream openConnectionToHostNamed: '127.0.0.1' port:  server port.
	allSockets add: newClient.
	^newClient
]

{ #category : #testing }
NeTcpServerTest >> newServer [
	| newServer |
	newServer := NeTcpServer port: NeTcpUsedPortsTracker freePortAtRandom.
	allServers add: newServer.
	^newServer
]

{ #category : #testing }
NeTcpServerTest >> setUp [
	super setUp.
	allServers := Set new.
	server := self newServer.
	self startServer.

]

{ #category : #testing }
NeTcpServerTest >> startServer [
	server start.
	self waitUntil: [ server isStarted ]
]

{ #category : #testing }
NeTcpServerTest >> stopServer [
	server stop.
	self waitWhile: [ server isStarted ] timeout: 2 seconds.

]

{ #category : #testing }
NeTcpServerTest >> tearDown [
	super tearDown.
	allServers do: #stop
]

{ #category : #testing }
NeTcpServerTest >> test1ClientConnection [
	| clientStream |
	clientStream := self newClientStream.
	self assert: clientStream isConnected
]

{ #category : #testing }
NeTcpServerTest >> testFastStartStop [
	self 
		shouldnt: [
			5 timesRepeat: [server stop; start]]
		raise: NeAlreadyUsedSocketPort

]

{ #category : #testing }
NeTcpServerTest >> testPortReleasedUponStop [
	self assert: (NeTcpUsedPortsTracker isUsedPort: server port).
	self stopServer.
	self deny: (NeTcpUsedPortsTracker isUsedPort: server port).

]

{ #category : #testing }
NeTcpServerTest >> testRestartAfterStop [
	| clientStream serverStream sentData receivedData|
	self stopServer.
	self deny: server socket isValid.
	server withCommunicationStreamDo: [ : stream | serverStream := stream ].
	self startServer.
	self assert: server socket isValid.
	clientStream := self newClientStream.
	self assert: clientStream isConnected.
	self waitWhile: [serverStream isNil].
	sentData := 'Hello Pharo!' asByteArray.
	clientStream nextPutAll: sentData; flush.
	receivedData := serverStream next: sentData size.
	self assert: receivedData equals: sentData.

]

{ #category : #testing }
NeTcpServerTest >> testSendReceive1Client [
	| clientStream serverStream receivedWord |
	server withCommunicationStreamDo: [ : stream | serverStream := stream ].
	clientStream := self newClientStream.
	self waitWhile: [serverStream isNil].
	 #('Hello' 'World' 'Pharo') do: [ : sentWord | 
		clientStream nextPutAll: sentWord; flush.
		receivedWord := (serverStream next: sentWord size) asString.
		self assert: receivedWord equals: sentWord].

]

{ #category : #testing }
NeTcpServerTest >> testStart [
	self assert: server socket isValid.
]

{ #category : #testing }
NeTcpServerTest >> testStop [
	self should: [ self stopServer ] notTakeMoreThan: 500 milliSeconds.
	self deny: server socket isValid.
]
