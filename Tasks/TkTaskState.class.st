Class {
	#name : #TkTaskState,
	#superclass : #SmState,
	#instVars : [
		'task'
	],
	#category : #'Tasks-Kernel-Tasks'
}

{ #category : #acting }
TkTaskState >> act [
	^self
]

{ #category : #initialization }
TkTaskState >> actAfter: aDuration [
	^self
]

{ #category : #testing }
TkTaskState >> dueTime [
	^self task dueTime
]

{ #category : #testing }
TkTaskState >> dueTime: aDateAndTime [
	^self task dueTime: aDateAndTime
]

{ #category : #testing }
TkTaskState >> isDone [
	^false
]

{ #category : #testing }
TkTaskState >> isDue [
	^true
]

{ #category : #testing }
TkTaskState >> isDueTimePassed [
	self dueTime ifNil: [ ^ true ].
	^ self dueTime <= self now
]

{ #category : #testing }
TkTaskState >> now [
	^self task now
]

{ #category : #accessing }
TkTaskState >> task [
	^ task
]

{ #category : #accessing }
TkTaskState >> task: anObject [
	task := anObject
]
