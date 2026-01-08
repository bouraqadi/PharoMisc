Class {
	#name : 'NeMulticastSocketTest',
	#superclass : 'NeUdpSocketTest',
	#instVars : [
		'socket',
		'multicastPort'
	],
	#category : 'NetworkExtras-Test',
	#package : 'NetworkExtras',
	#tag : 'Test'
}

{ #category : 'testing' }
NeMulticastSocketTest class >> isAbstract [ 
	^self == NeMulticastSocketTest 
]

{ #category : 'testing' }
NeMulticastSocketTest >> groupIp [
	self subclassResponsibility 
]

{ #category : 'testing' }
NeMulticastSocketTest >> setUp [

	super setUp.
	multicastPort := NeUdpUsedPortsTracker freePortAtRandom.
	socket := self
		          newMulticastSocketOnGroup: self groupIp 
		          port: multicastPort
]

{ #category : 'testing' }
NeMulticastSocketTest >> testGroupAddress [

	#( '224.0.0.1' '225.1.2.3' '230.220.210.200' '239.255.255.255' '127.0.0.1' ) do: [
		:groupIpString |
		self
			shouldnt: [
				self
					newMulticastSocketOnGroup: groupIpString
					port: NeUdpUsedPortsTracker freePortAtRandom ]
			raise: Error ].

	#( '223.1.2.3' '240.0.0.1' ) do: [ :groupIpString |
		self
			should: [
				self
					newMulticastSocketOnGroup: groupIpString
					port: NeUdpUsedPortsTracker freePortAtRandom ]
			raise: NeInvalidMulticastGroupIpError ]
]

{ #category : 'testing' }
NeMulticastSocketTest >> testInterface [
	<expectedFailure>
	self assert: socket networkInterface equals: #(0 0). "API to be improved"
	socket networkInterfaceIp: '10.89.2.24'.
	self fail: #todo
]

{ #category : 'testing' }
NeMulticastSocketTest >> testSendReceive [
	"Order is important! Since we are on the same machine and use the default interface, 
	receiver socket should be created first to ensure it will be fed packets by the OS. 
	Remeber that sockets are bidirectional."

	| sender receiver |
	receiver := socket.
	receiver unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender := self
		          newMulticastSocketOnGroup: self groupIp 
		          port: multicastPort.
	sender send: 'Hello'.
	self assert: (receiver receiveTimeout: 0.1) asString equals: 'Hello'
]

{ #category : 'testing' }
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
