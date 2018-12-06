"
I am an abstract class that provides behavior to track ports  used for reception to avoid having 2 sockets listening on the same port.

Use  one of my subclases.
"
Class {
	#name : #NeUsedPortsTracker,
	#superclass : #Object,
	#classInstVars : [
		'usedPorts'
	],
	#category : #'NetworkExtras-Kernel'
}

{ #category : #accessing }
NeUsedPortsTracker class >> freePortAtRandom [
	| allFreePorts |
	self usedPorts size = self totalAvailablePorts ifTrue: [^NeAllPortsUsedError signal].
	allFreePorts := (self minPortNumber to: self maxPortNumber) copyWithoutAll: self usedPorts. 
	^allFreePorts atRandom
]

{ #category : #'initialize-release' }
NeUsedPortsTracker class >> initUsedPorts [
	usedPorts := Set new
]

{ #category : #testing }
NeUsedPortsTracker class >> isUsedPort: portNumber [
	^self usedPorts includes: portNumber
]

{ #category : #accessing }
NeUsedPortsTracker class >> maxPortNumber [
	^65535
]

{ #category : #accessing }
NeUsedPortsTracker class >> minPortNumber [
	^1024
]

{ #category : #tracking }
NeUsedPortsTracker class >> registerUsedPort: portNumber [
	self usedPorts add: portNumber
]

{ #category : #'initialize-release' }
NeUsedPortsTracker class >> resetUsedPorts [
	usedPorts := nil
]

{ #category : #accessing }
NeUsedPortsTracker class >> totalAvailablePorts [
	^self maxPortNumber - self minPortNumber + 1
]

{ #category : #tracking }
NeUsedPortsTracker class >> unregisterUsedPort: portNumber [
	self usedPorts remove: portNumber ifAbsent: [  ]
]

{ #category : #accessing }
NeUsedPortsTracker class >> usedPorts [
	usedPorts ifNil: [ self initUsedPorts ].
	^usedPorts
]
