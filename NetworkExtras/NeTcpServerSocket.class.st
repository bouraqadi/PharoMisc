Class {
	#name : #NeTcpServerSocket,
	#superclass : #NeSocket,
	#category : #'NetworkExtras-TCP-Kernel'
}

{ #category : #'instance creation' }
NeTcpServerSocket class >> listenOnPort: portNumber [
	self ensureValidPort: portNumber.
	^self newTCP
		listenOn: portNumber;
		yourself
]

{ #category : #'instance creation' }
NeTcpServerSocket class >> listenOnPort: portNumber backlogSize: backlog [
	self ensureValidPort: portNumber.
	^self newTCP
		listenOn: portNumber backlogSize: backlog;
		yourself
]

{ #category : #'instance creation' }
NeTcpServerSocket class >> listenOnPort: portNumber backlogSize: backlog interface: ifAddr [
	self ensureValidPort: portNumber.
	^self newTCP
		listenOn: portNumber backlogSize: backlog interface: ifAddr;
		yourself
]
