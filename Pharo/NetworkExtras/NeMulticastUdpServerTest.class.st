Class {
	#name : 'NeMulticastUdpServerTest',
	#superclass : 'NeUdpServerTest',
	#instVars : [
		'multicastGroup',
		'multicastPort'
	],
	#category : 'NetworkExtras-Test',
	#package : 'NetworkExtras',
	#tag : 'Test'
}

{ #category : 'testing' }
NeMulticastUdpServerTest class >> isAbstract [ 
	^self == NeMulticastUdpServerTest 
]

{ #category : 'testing' }
NeMulticastUdpServerTest >> groupIp [

	self subclassResponsibility
]

{ #category : 'testing' }
NeMulticastUdpServerTest >> newServer [

	multicastGroup := self groupIp.
	multicastPort := NeUsedPortsTracker freePortAtRandom.
	^ NeMulticastServer group: multicastGroup port: multicastPort
]

{ #category : 'testing' }
NeMulticastUdpServerTest >> startServer [
	server start.
	server socket unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	"Order is important! Since we are on the same machine and use the default interface, 
	receiver socket should be created first to ensure it will be fed packets by the OS. 
	Remeber that sockets are bidirectional."
	sender := self newMulticastSocketOnGroup: multicastGroup port: multicastPort
]

{ #category : 'testing' }
NeMulticastUdpServerTest >> stopServer [
	super stopServer.
	sender closeAndDestroy.
]
