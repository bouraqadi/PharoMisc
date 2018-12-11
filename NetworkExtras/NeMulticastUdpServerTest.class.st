Class {
	#name : #NeMulticastUdpServerTest,
	#superclass : #NeUdpServerTest,
	#instVars : [
		'multicastGroup',
		'multicastPort'
	],
	#category : #'NetworkExtras-KernelTest'
}

{ #category : #testing }
NeMulticastUdpServerTest >> newServer [
	multicastGroup := '236.1.2.13'.
	multicastPort := NeUsedPortsTracker freePortAtRandom.
	^NeMulticastServer group: multicastGroup port: multicastPort.

]

{ #category : #testing }
NeMulticastUdpServerTest >> startServer [
	server start.
	server socket unregisterUsedPort. "Hack to allow having two multicast sockets on the same port!"
	"Order is important! Since we are on the same machine and use the default interface, 
	receiver socket should be created first to ensure it will be fed packets by the OS. 
	Remeber that sockets are bidirectional."
	sender := self newMulticastSocketOnGroup: multicastGroup port: multicastPort
]

{ #category : #testing }
NeMulticastUdpServerTest >> stopServer [
	super stopServer.
	sender closeAndDestroy.
]
