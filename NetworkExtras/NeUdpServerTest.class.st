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
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeUdpServerTest class >> isAbstract [
	^self == NeUdpServerTest 
]

{ #category : #testing }
NeUdpServerTest >> newServer [
	self subclassResponsibility

]

{ #category : #testing }
NeUdpServerTest >> setUp [
	super setUp.
	allReceivedData := OrderedCollection new.
	server := self newServer.
	server onReceptionDo: [ :data | allReceivedData add: data asString ].
	server priority: Processor userInterruptPriority.
	self startServer
]

{ #category : #testing }
NeUdpServerTest >> startServer [
	self subclassResponsibility
]

{ #category : #testing }
NeUdpServerTest >> stopServer [
	server stop.
]

{ #category : #testing }
NeUdpServerTest >> tearDown [
	super tearDown.
	self stopServer.

]

{ #category : #testing }
NeUdpServerTest >> testRestartAfterStop [
	| receivedData |
	server onReceptionDo: [ :data | receivedData := data asString ].
	#('Hello' 'World' 'Pharo') do: [ : sentData | 
		self startServer.
		sender send: sentData.
		200 milliSeconds wait.
		self assert: receivedData equals: sentData.
		self stopServer.
	].

]

{ #category : #testing }
NeUdpServerTest >> testSendReceive [
	| allSentData |
	allSentData := #('Hello' 'World' 'Pharo').
	allSentData withIndexDo: [ :each :index | 
		sender send: each.
		self waitUntil: [ allReceivedData size = index ].
	].
	self assert: allReceivedData asArray equals: allSentData
]

{ #category : #testing }
NeUdpServerTest >> testStopShouldQuicklyReturn [
	self should: [ server stop ] notTakeMoreThan: 500 milliSeconds 
]
