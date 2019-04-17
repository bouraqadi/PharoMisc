Class {
	#name : #NeTcpSocketTest,
	#superclass : #NeSocketTest,
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTcpSocketTest >> newTcpSocketListeningOnPort: port [
	^self createSocket: [NeTcpSocket listenOnPort: port]

]

{ #category : #testing }
NeTcpSocketTest >> newTcpSocketListeningOnPort: port backlogSize: backlogSize [
	^self createSocket: [NeTcpSocket listenOnPort: port  backlogSize: backlogSize]

]

{ #category : #testing }
NeTcpSocketTest >> newTcpSocketListeningOnPort: port backlogSize: backlogSize interface: itf [
	^self createSocket: [NeTcpSocket listenOnPort: port  backlogSize: backlogSize interface: itf]

]
