Class {
	#name : #TkStartedThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #testing }
TkStartedThreadState >> isStarted [
	^true
]

{ #category : #living }
TkStartedThreadState >> start [
	^self
]

{ #category : #living }
TkStartedThreadState >> stop [
	self thread isStopRequested: true
]
