Class {
	#name : #NeTcpSocketTest,
	#superclass : #NeSocketTest,
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTcpSocketTest >> newTcpSocketListeningOnPort: port [
	^self createSocket: [NeTcpServerSocket listenOnPort: port]

]

{ #category : #testing }
NeTcpSocketTest >> newTcpSocketListeningOnPort: port backlogSize: backlogSize [
	^self createSocket: [NeTcpServerSocket listenOnPort: port  backlogSize: backlogSize]

]

{ #category : #testing }
NeTcpSocketTest >> newTcpSocketListeningOnPort: port backlogSize: backlogSize interface: itf [
	^self createSocket: [NeTcpServerSocket listenOnPort: port  backlogSize: backlogSize interface: itf]

]
