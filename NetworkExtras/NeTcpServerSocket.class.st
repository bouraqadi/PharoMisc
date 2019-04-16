Class {
	#name : #NeTcpServerSocket,
	#superclass : #NeSocket,
	#category : #'NetworkExtras-TCP-Kernel'
}

{ #category : #'instance creation' }
NeTcpServerSocket class >> listenOnPort: portNumber [
	^self new
		listenOn: portNumber;
		yourself
]

{ #category : #'instance creation' }
NeTcpServerSocket class >> listenOnPort: portNumber backlogSize: backlog [
	^self new
		listenOn: portNumber backlogSize: backlog;
		yourself
]

{ #category : #'instance creation' }
NeTcpServerSocket class >> listenOnPort: portNumber backlogSize: backlog interface: ifAddr [
	^self new
		listenOn: portNumber backlogSize: backlog interface: ifAddr;
		yourself
]

{ #category : #'instance creation' }
NeTcpServerSocket class >> newIfFail: aBlock [
	^self tcpCreateIfFail: aBlock
]

{ #category : #'connection open/close' }
NeTcpServerSocket >> listenOn: portNumber [
	self receptionPort: portNumber.
	^super listenOn: portNumber

]

{ #category : #'connection open/close' }
NeTcpServerSocket >> listenOn: portNumber backlogSize: backlog [
	self receptionPort: portNumber.
	^super listenOn: portNumber backlogSize: backlog

]

{ #category : #'connection open/close' }
NeTcpServerSocket >> listenOn: portNumber backlogSize: backlog interface: ifAddr [
	self receptionPort: portNumber.
	^super listenOn: portNumber backlogSize: backlog interface: ifAddr

]

{ #category : #'reception ports tracking' }
NeTcpServerSocket >> usedPortsTracker [
	^NeTcpUsedPortsTracker
]
