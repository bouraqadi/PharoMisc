Class {
	#name : #NeSocket,
	#superclass : #Socket,
	#category : #'NetworkExtras-Kernel'
}

{ #category : #testing }
NeSocket class >> ensureValidPort: portNumber [
	(self isValidPort: portNumber) ifTrue: [ ^self ].
	NeInvalidSocketPortError signal
]

{ #category : #testing }
NeSocket class >> isValidPort: portNumber [
	portNumber < 0 ifTrue: [ ^false ].
	portNumber > 65535 ifTrue: [ ^false ].
	^true
]

{ #category : #testing }
NeSocket >> ensureValidPort: portNumber [
	^self class ensureValidPort: portNumber.

]
