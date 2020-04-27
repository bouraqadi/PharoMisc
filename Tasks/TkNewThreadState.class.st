Class {
	#name : #TkNewThreadState,
	#superclass : #TkStartableThreadState,
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #public }
TkNewThreadState >> restart [
	self start
]
