Class {
	#name : #TkThread,
	#superclass : #Object,
	#instVars : [
		'task',
		'automaton',
		'stoppedState',
		'priority',
		'startedState',
		'process'
	],
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #'instance creation' }
TkThread class >> repeat: actionBlock [
	^self new
		task: (TkTask repeat: actionBlock);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: actionBlock until: endBlock every: aDuration [ 
	^self new
		task: (TkTask repeat: actionBlock until: endBlock every: aDuration);
		yourself
]

{ #category : #initialization }
TkThread >> defaultPriority [
	^30
]

{ #category : #initialization }
TkThread >> initialize [
	super initialize.
	self priority: self defaultPriority.
	automaton := SmAutomaton new.
	stoppedState := self newState: TkStoppedThreadState.
	automaton initialState: stoppedState.
	startedState := self newState: TkStartedThreadState.
	startedState entryActionBlock: [self startProcess].

]

{ #category : #testing }
TkThread >> isDone [
	^self task isDone
]

{ #category : #testing }
TkThread >> isKilled [
	^self state isKilled
]

{ #category : #testing }
TkThread >> isStarted [
	^self state isStarted
]

{ #category : #testing }
TkThread >> isStopped [
	^self state isStopped
]

{ #category : #testing }
TkThread >> isStopping [
	^self state isStopping
]

{ #category : #living }
TkThread >> kill [
	^self state kill
]

{ #category : #initialization }
TkThread >> newState: stateClass [
	| newState |
	newState := automaton newState: stateClass.
	newState thread: self.
	^newState
]

{ #category : #accessing }
TkThread >> priority [
	^ priority
]

{ #category : #accessing }
TkThread >> priority: anObject [
	priority := anObject
]

{ #category : #living }
TkThread >> start [
	^self state start
]

{ #category : #living }
TkThread >> startProcess [
	self process resume
]

{ #category : #accessing }
TkThread >> state [
	^ automaton currentState
]

{ #category : #living }
TkThread >> stop [
	^self state stop
]

{ #category : #accessing }
TkThread >> task [
	^ task
]

{ #category : #accessing }
TkThread >> task: anObject [
	task := anObject
]
