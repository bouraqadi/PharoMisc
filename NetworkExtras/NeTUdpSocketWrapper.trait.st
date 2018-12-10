"
I provide facility methods common among socket wrappers
"
Trait {
	#name : #NeTUdpSocketWrapper,
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeTUdpSocketWrapper classSide >> socket: udpSocket [
	^self new
		socket: udpSocket;
		yourself
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
