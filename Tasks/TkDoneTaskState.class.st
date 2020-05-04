Class {
	#name : #TkDoneTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Private-Tasks'
}

{ #category : #testing }
TkDoneTaskState >> isDone [
	^true
]

{ #category : #testing }
TkDoneTaskState >> isDue [
	^false
]
