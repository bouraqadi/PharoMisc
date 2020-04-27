Class {
	#name : #TkThread,
	#superclass : #Object,
	#instVars : [
		'task',
		'automaton',
		'stoppedState',
		'priority',
		'startedState',
		'process',
		'stoppingState',
		'isStopRequested',
		'killedState',
		'doneState'
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
TkThread class >> repeat: aBlockClosure times: anInteger [ 
	^self new
		task: (TkTask repeat: aBlockClosure times: anInteger);
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
	startedState
		entryActionBlock: [self startProcess];
		mainActionBlock: [ self stepTask ].
	killedState := self newState: TkKilledThreadState.
	doneState := self newState: TkDoneThreadState.
	stoppedState transitionTo: startedState.
	startedState transitionTo: stoppedState when: [self isStopRequested].
	startedState transitionTo: killedState when: [ self isProcessTerminated ].	
	startedState transitionTo: doneState when: [ self isTaskDone ].	
	
]

{ #category : #testing }
TkThread >> isDone [
	^self state isDone
]

{ #category : #testing }
TkThread >> isKilled [
	^self state isKilled
]

{ #category : #testing }
TkThread >> isProcessTerminated [
	^self process isTerminated
]

{ #category : #testing }
TkThread >> isStarted [
	^self state isStarted
]

{ #category : #testing }
TkThread >> isStopConditionMet [
	^self isStopRequested or: [ self isTaskDone ]

]

{ #category : #testing }
TkThread >> isStopRequested [
	^ isStopRequested
]

{ #category : #accessing }
TkThread >> isStopRequested: anObject [
	^ isStopRequested := anObject
]

{ #category : #testing }
TkThread >> isStopped [
	^self state isStopped
]

{ #category : #testing }
TkThread >> isTaskDone [
	^self task isDone
]

{ #category : #living }
TkThread >> kill [
	^self state kill
]

{ #category : #living }
TkThread >> loop [
	[self isStopConditionMet] whileFalse: [self step].
	automaton step.

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
TkThread >> priority: newPriority [
	priority := newPriority.

]

{ #category : #accessing }
TkThread >> process [
	^process
]

{ #category : #living }
TkThread >> start [
	^self state start
]

{ #category : #living }
TkThread >> startProcess [
	self isStopRequested: false.
	process := [self loop] forkAt: self priority.
	
]

{ #category : #accessing }
TkThread >> state [
	^ automaton currentState
]

{ #category : #living }
TkThread >> step [
	automaton step
]

{ #category : #living }
TkThread >> stepTask [
	self task step
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

{ #category : #living }
TkThread >> terminateProcess [
	self process terminate
]
