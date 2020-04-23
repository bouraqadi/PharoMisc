Class {
	#name : #TkTaskState,
	#superclass : #SmState,
	#instVars : [
		'task'
	],
	#category : #Tasks
}

{ #category : #acting }
TkTaskState >> act [
	^self
]

{ #category : #testing }
TkTaskState >> isDone [
	^false
]

{ #category : #testing }
TkTaskState >> isDue [
	^true
]

{ #category : #accessing }
TkTaskState >> task [
	^ task
]

{ #category : #accessing }
TkTaskState >> task: anObject [
	task := anObject
]
