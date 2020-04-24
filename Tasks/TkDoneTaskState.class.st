Class {
	#name : #TkDoneTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel'
}

{ #category : #testing }
TkDoneTaskState >> isDone [
	^true
]

{ #category : #testing }
TkDoneTaskState >> isDue [
	^false
]
