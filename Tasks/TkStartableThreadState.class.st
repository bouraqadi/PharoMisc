Class {
	#name : #TkStartableThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Private-Thread'
}

{ #category : #living }
TkStartableThreadState >> start [
	self automaton step
]
