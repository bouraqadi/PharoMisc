Class {
	#name : #TkStoppedThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #testing }
TkStoppedThreadState >> isStopped [
	^true
]

{ #category : #living }
TkStoppedThreadState >> start [
	self step
]
