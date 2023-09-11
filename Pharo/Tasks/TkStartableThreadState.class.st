Class {
	#name : #TkStartableThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Private-Thread'
}

{ #category : #living }
TkStartableThreadState >> start [
	self automaton step
]

{ #category : #living }
TkStartableThreadState >> startAfter: aDuration [
	self thread actAfter: aDuration.
	self start.
]

{ #category : #living }
TkStartableThreadState >> startOn: aDateAndTime [
	self thread actOn: aDateAndTime.
	self start.
]
