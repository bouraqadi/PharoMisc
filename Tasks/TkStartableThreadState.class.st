Class {
	#name : #TkStartableThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #living }
TkStartableThreadState >> start [
	self automaton step
]
