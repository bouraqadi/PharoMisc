Class {
	#name : #NeTcpSocket,
	#superclass : #NeSocket,
	#category : #'NetworkExtras-TCP-Kernel'
}

{ #category : #'instance creation' }
NeTcpSocket class >> listenOn: portNumber [
	^self new
		listenOn: portNumber;
		yourself
]

{ #category : #'instance creation' }
NeTcpSocket class >> listenOnPort: portNumber backlogSize: backlog [
	^self new
		listenOn: portNumber backlogSize: backlog;
		yourself
]

{ #category : #'instance creation' }
NeTcpSocket class >> listenOnPort: portNumber backlogSize: backlog interface: ifAddr [
	^self new
		listenOn: portNumber backlogSize: backlog interface: ifAddr;
		yourself
]

{ #category : #'instance creation' }
NeTcpSocket class >> newIfFail: aBlock [
	^self tcpCreateIfFail: aBlock
]

{ #category : #'connection open/close' }
NeTcpSocket >> listenOn: portNumber [
	self receptionPort: portNumber.
	^super listenOn: portNumber

]

{ #category : #'connection open/close' }
NeTcpSocket >> listenOn: portNumber backlogSize: backlog [
	self receptionPort: portNumber.
	^super listenOn: portNumber backlogSize: backlog

]

{ #category : #'connection open/close' }
NeTcpSocket >> listenOn: portNumber backlogSize: backlog interface: ifAddr [
	self receptionPort: portNumber.
	^super listenOn: portNumber backlogSize: backlog interface: ifAddr

]

{ #category : #printing }
NeTcpSocket >> printSocketInfoOn: aWriteStream [ 
	self receptionPort ifNil: [^self].
	^aWriteStream
		nextPutAll: 'Reception Port: ';
		print: self receptionPort

]

{ #category : #'reception ports tracking' }
NeTcpSocket >> usedPortsTracker [
	^NeTcpUsedPortsTracker
]
