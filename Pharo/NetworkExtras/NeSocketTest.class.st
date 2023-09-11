"
Shared behavior for UDP socket classes
"
Class {
	#name : #NeSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'allSockets'
	],
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeSocketTest class >> isAbstract [
	^self == NeSocketTest 
]

{ #category : #testing }
NeSocketTest >> createSocket: aBlock [
	| newSocket |
	newSocket := aBlock value.
	allSockets add: newSocket.
	^newSocket
]

{ #category : #testing }
NeSocketTest >> runCaseManaged [
	"This library does manage its own forked processes"
	self runCase
]

{ #category : #testing }
NeSocketTest >> setUp [
	super setUp.
	allSockets := Set new.

]

{ #category : #testing }
NeSocketTest >> tearDown [
	super tearDown.	
	allSockets do: [: each | each closeAndDestroy].

]
