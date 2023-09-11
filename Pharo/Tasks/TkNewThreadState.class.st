Class {
	#name : #TkNewThreadState,
	#superclass : #TkStartableThreadState,
	#category : #'Tasks-Private-Thread'
}

{ #category : #accessing }
TkNewThreadState >> name [
	^'New'
]

{ #category : #public }
TkNewThreadState >> restart [
	self start
]
