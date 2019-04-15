Class {
	#name : #NeTcpSocketPortTest,
	#superclass : #NeTcpSocketTest,
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTcpSocketPortTest >> testListeningPort [
	self should: [ self newTcpSocketListeningOnPort: -1 ] raise: NeInvalidSocketPortError.
	self should: [ 
		NeTcpServerSocket listenOnPort: -1  backlogSize:  10] raise: NeInvalidSocketPortError.
	self should: [ 
		NeTcpServerSocket 
			listenOnPort: -1
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.
		
	self shouldnt: [ self newTcpSocketListeningOnPort: 0 ] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		NeTcpServerSocket listenOnPort: 0  backlogSize:  10] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		NeTcpServerSocket 
			listenOnPort: 0
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.
		
	self shouldnt: [ self newTcpSocketListeningOnPort: 65535 ] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		NeTcpServerSocket listenOnPort: 65535  backlogSize:  10] raise: NeInvalidSocketPortError.
	self shouldnt: [ 
		NeTcpServerSocket 
			listenOnPort: 65535
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.
		
	self should: [ self newTcpSocketListeningOnPort: 65536 ] raise: NeInvalidSocketPortError.
	self should: [ 
		NeTcpServerSocket listenOnPort: 65536  backlogSize:  10] raise: NeInvalidSocketPortError.
	self should: [ 
		NeTcpServerSocket 
			listenOnPort: 65536
			backlogSize:  10
			interface: NeIpV4Address loopback] raise: NeInvalidSocketPortError.

]

{ #category : #testing }
NeTcpSocketPortTest >> testValidUnicastEmissionPort [
self fail: #todo.
	self should: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: -1] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: 0] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: 65535] raise: NeInvalidSocketPortError.
	self should: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: 65536] raise: NeInvalidSocketPortError.

]
