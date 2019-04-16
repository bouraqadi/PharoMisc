Class {
	#name : #NeTcpSocketPortTest,
	#superclass : #NeTcpSocketTest,
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTcpSocketPortTest >> testPortAvailability [
	| freePort |
	freePort := NeTcpUsedPortsTracker freePortAtRandom.
	self newTcpSocketListeningOnPort: freePort.
	self should: [ self newTcpSocketListeningOnPort: freePort ] raise: NeAlreadyUsedSocketPort.

]

{ #category : #testing }
NeTcpSocketPortTest >> testPortNumberValidityListenOn [
	self should: [ self newTcpSocketListeningOnPort: -1 ] raise: NeInvalidSocketPortError.		
	self shouldnt: [ self newTcpSocketListeningOnPort: 0 ] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newTcpSocketListeningOnPort: 65535 ] raise: NeInvalidSocketPortError.
	self should: [ self newTcpSocketListeningOnPort: 65536 ] raise: NeInvalidSocketPortError.

]

{ #category : #testing }
NeTcpSocketPortTest >> testPortNumberValidityListenOnBacklogSize [
	self should: [ 
		self newTcpSocketListeningOnPort: -1  backlogSize:  10] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		self newTcpSocketListeningOnPort: 0  backlogSize:  10] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		self newTcpSocketListeningOnPort: 65535  backlogSize:  10] raise: NeInvalidSocketPortError.
	self should: [ 
		self newTcpSocketListeningOnPort: 65536  backlogSize:  10] raise: NeInvalidSocketPortError.

]

{ #category : #testing }
NeTcpSocketPortTest >> testPortNumberValidityListenOnBacklogSizeInterface [
	self should: [ 
		self newTcpSocketListeningOnPort: -1
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		self newTcpSocketListeningOnPort: 0
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		self newTcpSocketListeningOnPort: 65535
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.
	self should: [ 
		self newTcpSocketListeningOnPort: 65536
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.

]
