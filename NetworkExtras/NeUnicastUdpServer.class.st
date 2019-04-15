"
I am a UDP Unicast server. I handle incoming UDP data repeatedly in a dedicated thread.

"
Class {
	#name : #NeUnicastUdpServer,
	#superclass : #NeUdpServer,
	#instVars : [
		'port'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUnicastUdpServer class >> port: portNumber [
	^self new
		port: portNumber;
		yourself
]

{ #category : #activity }
NeUnicastUdpServer >> defaultServerName [
	^ 'UDP unicast server'
]

{ #category : #activity }
NeUnicastUdpServer >> newSocket [
	^NeUnicastUdpSocket listenOnPort: self port
]

{ #category : #accessing }
NeUnicastUdpServer >> port [
	^ port
]

{ #category : #accessing }
NeUnicastUdpServer >> port: anObject [
	port := anObject
]
