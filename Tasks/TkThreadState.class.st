Class {
	#name : #TkThreadState,
	#superclass : #SmState,
	#instVars : [
		'thread'
	],
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #testing }
TkThreadState >> isDone [
	^false
]

{ #category : #testing }
TkThreadState >> isKilled [
	^false
]

{ #category : #testing }
TkThreadState >> isStarted [
	^false
]

{ #category : #testing }
TkThreadState >> isStopped [
	^false
]

{ #category : #living }
TkThreadState >> kill [
	self thread terminateProcess.
	self automaton step
]

{ #category : #living }
TkThreadState >> start [
	self automaton step
]

{ #category : #living }
TkThreadState >> stop [
	^self
]

{ #category : #accessing }
TkThreadState >> thread [
	^ thread
]

{ #category : #accessing }
TkThreadState >> thread: anObject [
	thread := anObject
]
