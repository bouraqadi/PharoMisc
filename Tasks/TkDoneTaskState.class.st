Class {
	#name : #TkDoneTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel-Tasks'
}

{ #category : #testing }
TkDoneTaskState >> isDone [
	^true
]

{ #category : #testing }
TkDoneTaskState >> isDue [
	^false
]
