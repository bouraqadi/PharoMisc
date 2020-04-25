Class {
	#name : #TkThreadState,
	#superclass : #SmState,
	#instVars : [
		'thread'
	],
	#category : #'Tasks-Kernel-Threads'
}

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

{ #category : #testing }
TkThreadState >> isStopping [
	^false
]

{ #category : #living }
TkThreadState >> kill [
]

{ #category : #living }
TkThreadState >> start [
]

{ #category : #living }
TkThreadState >> stop [
]

{ #category : #accessing }
TkThreadState >> thread [
	^ thread
]

{ #category : #accessing }
TkThreadState >> thread: anObject [
	thread := anObject
]
