Class {
	#name : #TkStoppedThreadState,
	#superclass : #TkStartableThreadState,
	#category : #'Tasks-Private-Thread'
}

{ #category : #testing }
TkStoppedThreadState >> isStopped [
	^true
]

{ #category : #accessing }
TkStoppedThreadState >> name [
	^'Stopped'
]
