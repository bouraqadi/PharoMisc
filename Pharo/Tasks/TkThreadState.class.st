Class {
	#name : #TkThreadState,
	#superclass : #SmState,
	#instVars : [
		'thread'
	],
	#category : #'Tasks-Private-Thread'
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
	^self
]

{ #category : #accessing }
TkThreadState >> name [
	^self subclassResponsibility
]

{ #category : #living }
TkThreadState >> restart [
	self thread resetTask.
	self automaton step.
]

{ #category : #living }
TkThreadState >> restartAfter: aDuration [
	self thread resetTask.
	self thread actAfter: aDuration.
	self automaton step.

]

{ #category : #living }
TkThreadState >> restartOn: aDateAndTime [
	self thread resetTask.
	self thread actOn: aDateAndTime.
	self automaton step.

]

{ #category : #living }
TkThreadState >> start [
	^self
]

{ #category : #living }
TkThreadState >> startAfter: aDuration [
	^self
]

{ #category : #living }
TkThreadState >> startOn: aDateAndTime [
	^self
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
