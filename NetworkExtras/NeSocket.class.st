Class {
	#name : #NeSocket,
	#superclass : #Socket,
	#instVars : [
		'receptionPort'
	],
	#category : #'NetworkExtras-Kernel'
}

{ #category : #'instance creation' }
NeSocket class >> new [
	^self newIfFail: [
		UIManager default 
			abort: 'Either network is not available, or no resources left to create another socket'
			title: self name, ' creation failed!' ]
]

{ #category : #'instance creation' }
NeSocket class >> newIfFail: aBlock [
	self subclassResponsibility
]

{ #category : #'reception ports tracking' }
NeSocket >> destroy [
	[ super destroy ] ensure: [ self unregisterUsedPort]
]

{ #category : #'reception ports tracking' }
NeSocket >> ensureValidPort: portNumber [
	self usedPortsTracker ensureValidPort: portNumber
]

{ #category : #receiving }
NeSocket >> receptionPort [
	^receptionPort
]

{ #category : #initialization }
NeSocket >> receptionPort: portNumber [
	self registerUsedPort: portNumber.
	receptionPort := portNumber.

]

{ #category : #'reception ports tracking' }
NeSocket >> registerUsedPort: portNumber [
	self usedPortsTracker registerUsedPort: portNumber
]

{ #category : #'reception ports tracking' }
NeSocket >> unregisterUsedPort [
	self usedPortsTracker unregisterUsedPort: self receptionPort
]

{ #category : #'reception ports tracking' }
NeSocket >> usedPortsTracker [
	self subclassResponsibility
]
