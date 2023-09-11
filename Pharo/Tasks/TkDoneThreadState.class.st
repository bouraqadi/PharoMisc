Class {
	#name : #TkDoneThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Private-Thread'
}

{ #category : #testing }
TkDoneThreadState >> isDone [
	^true
]

{ #category : #accessing }
TkDoneThreadState >> name [
	^#Done
]
