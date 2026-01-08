"
Multicast test that require being on a network with a router that enables multicast communication
"
Class {
	#name : 'NeRoutedAddressMulticastSocketTest',
	#superclass : 'NeMulticastSocketTest',
	#category : 'NetworkExtras-Test',
	#package : 'NetworkExtras',
	#tag : 'Test'
}

{ #category : 'testing' }
NeRoutedAddressMulticastSocketTest >> groupIp [

	^ '226.1.2.3'
]

{ #category : 'testing' }
NeRoutedAddressMulticastSocketTest >> testLoopbackMode [
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

{ #category : 'testing' }
NeRoutedAddressMulticastSocketTest >> testSendReceiveOnDifferentGroups [

	| sender1 receiver1 receiver2 multicastPort2 otherGroupIp sender2 message1 message2 |
	receiver1 := socket.
	receiver1 unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender1 := self
		           newMulticastSocketOnGroup: self groupIp
		           port: multicastPort.
	multicastPort2 := NeUdpUsedPortsTracker freePortAtRandom.
	otherGroupIp := '226.1.1.42'.
	self deny: otherGroupIp asIpAddress equals: self groupIp asIpAddress.
	receiver2 := self
		             newMulticastSocketOnGroup: otherGroupIp
		             port: multicastPort2.
	receiver2 unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	sender2 := self
		           newMulticastSocketOnGroup: otherGroupIp
		           port: multicastPort2.
	message1 := 'Hello111'.
	message2 := 'Hello222'.
	sender1 send: message1.
	sender2 send: message2.
	self
		assert: (receiver1 receiveTimeout: 0.1) asString
		equals: message1.
	self
		assert: (receiver2 receiveTimeout: 0.1) asString
		equals: message2
]
