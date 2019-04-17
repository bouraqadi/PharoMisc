Class {
	#name : #NeTcpServer,
	#superclass : #NeServer,
	#instVars : [
		'port'
	],
	#category : #'NetworkExtras-TCP-Kernel'
}

{ #category : #'instance creation' }
NeTcpServer class >> port: portNumber [
	^self new
		port: portNumber;
		yourself
]

{ #category : #'initialize-release' }
NeTcpServer >> defaultServerName [
	^'TCP Server'
]

{ #category : #activity }
NeTcpServer >> newSocket [
	^NeTcpSocket listenOnPort: self port
]

{ #category : #accessing }
NeTcpServer >> port [
	^ port
]

{ #category : #accessing }
NeTcpServer >> port: anObject [
	port := anObject
]

{ #category : #activity }
NeTcpServer >> servingStep [
]
