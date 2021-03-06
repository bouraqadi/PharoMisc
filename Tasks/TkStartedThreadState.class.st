Class {
	#name : #TkStartedThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Private-Thread'
}

{ #category : #testing }
TkStartedThreadState >> isStarted [
	^true
]

{ #category : #living }
TkStartedThreadState >> kill [
	self thread terminateProcess.
	self automaton step
]

{ #category : #accessing }
TkStartedThreadState >> name [
	^'Started'
]

{ #category : #living }
TkStartedThreadState >> restart [
	self kill.
	super restart.
]

{ #category : #living }
TkStartedThreadState >> restartAfter: aDuration [
	self kill.
	super restartAfter: aDuration.
]

{ #category : #living }
TkStartedThreadState >> restartOn: aDateAndTime [
	self kill.
	super restartOn: aDateAndTime.
]

{ #category : #living }
TkStartedThreadState >> start [
	^self
]

{ #category : #living }
TkStartedThreadState >> stop [
	self thread isStopRequested: true
]
