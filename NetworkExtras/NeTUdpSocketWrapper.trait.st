"
I provide facility methods common among socket wrappers
"
Trait {
	#name : #NeTUdpSocketWrapper,
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeTUdpSocketWrapper classSide >> broadcastIp: ipStringOrByteArray port: portNumber [
	^ self socket: (NeBroadcastSocket ip: ipStringOrByteArray port: portNumber)
]

{ #category : #'instance creation' }
NeTUdpSocketWrapper classSide >> broadcastPort: portNumber [
	^ self socket: (NeBroadcastSocket port: portNumber)
]

{ #category : #'instance creation' }
NeTUdpSocketWrapper classSide >> multicastSocketGroup: groupIp port: port [
	| socket |
	socket := NeMulticastSocket group: groupIp port: port.
	^ self socket: socket
]

{ #category : #'instance creation' }
NeTUdpSocketWrapper classSide >> receptionPort: portNumber [
	^ self socket: (NeUnicastUdpSocket receptionPort: portNumber)
]

{ #category : #'instance creation' }
NeTUdpSocketWrapper classSide >> socket: udpSocket [
	^self new
		socket: udpSocket;
		yourself
]

{ #category : #'instance creation' }
NeTUdpSocketWrapper classSide >> targetIp: ipStringOrByteArray port: portNumber [
	^ self socket: (NeUnicastUdpSocket targetIp: ipStringOrByteArray port: portNumber)
]

{ #category : #'initialize-release' }
NeTUdpSocketWrapper >> destroySocket [
	self socket closeAndDestroy
]

{ #category : #accessing }
NeTUdpSocketWrapper >> socket [
	self explicitRequirement
]

{ #category : #accessing }
NeTUdpSocketWrapper >> socket: udpSocket [
	self explicitRequirement
]
