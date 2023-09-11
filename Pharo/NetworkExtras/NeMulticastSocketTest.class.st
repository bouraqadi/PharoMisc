Class {
	#name : #NeMulticastSocketTest,
	#superclass : #NeUdpSocketTest,
	#instVars : [
		'socket',
		'multicastPort'
	],
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeMulticastSocketTest >> setUp [
	super setUp.
	multicastPort := NeUdpUsedPortsTracker freePortAtRandom.
	socket := self newMulticastSocketOnGroup: '226.0.0.12'
				port: multicastPort
]

{ #category : #testing }
NeMulticastSocketTest >> testGroupAddress [
	
	#('224.0.0.1' '225.1.2.3' '230.220.210.200' '239.255.255.255') do: [ : groupIpString |
		self 
			shouldnt: [self newMulticastSocketOnGroup: groupIpString port: NeUdpUsedPortsTracker freePortAtRandom] 
			raise: Error].
	
	#('223.1.2.3' '240.0.0.1') do:  [ : groupIpString |
		self
			should: [self newMulticastSocketOnGroup: groupIpString port: NeUdpUsedPortsTracker freePortAtRandom] 
			raise: NeInvalidMulticastGroupIpError].
]

{ #category : #testing }
NeMulticastSocketTest >> testInterface [
	<expectedFailure>
	self assert: socket networkInterface equals: #(0 0). "API to be improved"
	socket networkInterfaceIp: '10.89.2.24'.
	self fail: #todo
]

{ #category : #testing }
NeMulticastSocketTest >> testLoopbackMode [
	| sentData |
	self assert: socket isLoopbackModeEnabled.
	sentData := 'hello'.
	socket send: sentData.
	self assert: (socket receiveTimeout: 0.1) asString equals: sentData.
	
	socket isLoopbackModeEnabled: false.
	self deny: socket isLoopbackModeEnabled.
	socket send: sentData.
	self should: [socket receiveTimeout: 0.1] raise: ConnectionTimedOut
]

{ #category : #testing }
NeMulticastSocketTest >> testSendReceive [
	"Order is important! Since we are on the same machine and use the default interface, 
	receiver socket should be created first to ensure it will be fed packets by the OS. 
	Remeber that sockets are bidirectional."
	| sender receiver |
	receiver := socket.
	receiver unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender := self newMulticastSocketOnGroup: '226.0.0.12'
				port: multicastPort.
	sender send: 'Hello'.
	self assert: (receiver receiveTimeout: 0.1) asString equals: 'Hello'

]

{ #category : #testing }
NeMulticastSocketTest >> testSendReceiveOnDifferentGroups [
	| sender1 receiver1 sender2 receiver2 multicastPort2 |
	receiver1 := socket.
	receiver1 unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender1 := self newMulticastSocketOnGroup:'226.0.0.12' port: multicastPort.
	multicastPort2 := NeUdpUsedPortsTracker freePortAtRandom.
	receiver2 := self newMulticastSocketOnGroup: '226.0.0.42' port: multicastPort2.
	receiver2 unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender2 := self newMulticastSocketOnGroup: '226.0.0.42' port: multicastPort2.
	sender1 send: 'Hello'.
	self assert: (receiver1 receiveTimeout: 0.1) asString equals: 'Hello'.
	self should: [ receiver2 receiveTimeout: 0.1 ] raise: ConnectionTimedOut.
	sender2 send: 'Goodbye'.
	self assert: (receiver2 receiveTimeout: 0.1) asString equals: 'Goodbye'.
	self should: [ receiver1 receiveTimeout: 0.1 ] raise: ConnectionTimedOut.

]

{ #category : #testing }
NeMulticastSocketTest >> testTimeToLive [
	| setTTLResult getTTLResult |
	self assert: socket timeToLive equals: 1.
	(2 to: 255), { 1. 0 } do: [: timeToLive|
		setTTLResult := socket timeToLive: timeToLive.
		getTTLResult := socket timeToLive.
		self assert: setTTLResult equals: timeToLive.
		self assert: getTTLResult equals: timeToLive].
	self should: [ socket timeToLive: 256 ] raise: Error.
]
