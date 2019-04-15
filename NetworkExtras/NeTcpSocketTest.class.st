Class {
	#name : #NeTcpSocketTest,
	#superclass : #NeSocketTest,
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTcpSocketTest >> newTcpSocketListeningOnPort: port [
	^self createSocket: [NeTcpServerSocket listenOnPort: port]

]
