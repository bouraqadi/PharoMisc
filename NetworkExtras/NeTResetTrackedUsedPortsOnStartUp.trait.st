"
I am a trait that provides behavior to track ports  used for reception to avoid having 2 sockets listening on the same port.

I am used for both TCP and UDP. See
NeTcpUsedPortsTracker
NeUdpUsedPortsTracker
"
Trait {
	#name : #NeTResetTrackedUsedPortsOnStartUp,
	#category : #'NetworkExtras-Kernel'
}

{ #category : #initialization }
NeTResetTrackedUsedPortsOnStartUp classSide >> initialize [
	Smalltalk addToStartUpList: self
]

{ #category : #'system startup' }
NeTResetTrackedUsedPortsOnStartUp classSide >> startUp: isImageStarting [
	isImageStarting ifFalse: [ ^self ].
	self resetUsedPorts.
]
