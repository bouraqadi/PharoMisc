Class {
	#name : #TkThread,
	#superclass : #Object,
	#instVars : [
		'name',
		'task',
		'automaton',
		'stoppedState',
		'priority',
		'startedState',
		'process',
		'stoppingState',
		'isStopRequested',
		'killedState',
		'doneState',
		'newThreadState',
		'isFinalizationEnabled'
	],
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #examples }
TkThread class >> autoStopOnGarbageCollect [
	<example>
	|counter thread |
	counter := 0.
	thread := self 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 300 milliSeconds.
	thread start.
	100 milliSeconds wait.
	thread := nil.
	Smalltalk garbageCollect.
]

{ #category : #'instance creation' }
TkThread class >> doOnce: aBlock [
	^self new
		task: (TkTask doOnce: aBlock);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> new [
	^TkThreadFinalizer thread: super new.
]

{ #category : #examples }
TkThread class >> persistingThread [
	<example>
	|counter thread |
	counter := 0.
	thread := self 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		while: [ counter < 10 ]
		every: 200 milliSeconds.
	thread persistUntillDone. "Ensure thread survices even if we lose the reference"
	thread start.
	thread := nil.
	Smalltalk garbageCollect.

]

{ #category : #examples }
TkThread class >> pingPong [
	<example>
	|ping pong |
	Transcript open.
	ping := self 
		repeat: [Transcript cr; show: '--------ping']
		every: 400 milliSeconds.
	pong := self 
		repeat: [Transcript cr; show: 'PONG']
		every: 200 milliSeconds.
	ping start.
	pong start.
	UIManager default centeredAlert: 'click to stop' title: 'Tasks' configure: [:any| ] .
	ping stop.
	pong stop

]

{ #category : #'instance creation' }
TkThread class >> repeat: actionBlock [
	^self new
		task: (TkTask repeat: actionBlock);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: aBlockClosure during: aDuration [  
	^self new
		task: (TkTask repeat: aBlockClosure during: aDuration);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: aBlockClosure during: aDuration every: period [
	^self new
		task: (TkTask repeat: aBlockClosure during: aDuration every: period);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: aBlockClosure every: aDuration [ 
	^(self repeat: aBlockClosure)
		period: aDuration;
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: aBlockClosure times: anInteger [ 
	^self new
		task: (TkTask repeat: aBlockClosure times: anInteger);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: aBlockClosure times: anInteger every: aDuration [ 
	^self new
		task: (TkTask repeat: aBlockClosure times: anInteger every: aDuration );
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: actionBlock until: endBlock [
	^self new
		task: (TkTask repeat: actionBlock until: endBlock);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: actionBlock until: endBlock every: aDuration [ 
	^self new
		task: (TkTask repeat: actionBlock until: endBlock every: aDuration);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: actionBlock while: endBlock [
	^self new
		task: (TkTask repeat: actionBlock while: endBlock);
		yourself
]

{ #category : #'instance creation' }
TkThread class >> repeat: actionBlock while: endBlock every: aDuration [ 
	^self new
		task: (TkTask repeat: actionBlock while: endBlock every: aDuration);
		yourself
]

{ #category : #examples }
TkThread class >> waitUntilDone [
	<example>
	|counter thread |
	counter := 0.
	thread := self 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		times: 10
		every: 100 milliSeconds.
	thread start.
	thread waitDone.
]

{ #category : #initialization }
TkThread >> defaultName [
	^self printString
]

{ #category : #initialization }
TkThread >> defaultPriority [
	^30
]

{ #category : #living }
TkThread >> defaultWaitDoneTimoutDuration [
	^3 seconds
]

{ #category : #initialization }
TkThread >> disableFinalization [
	isFinalizationEnabled := false
]

{ #category : #initialization }
TkThread >> enableFinalization [
	isFinalizationEnabled := true
]

{ #category : #accessing }
TkThread >> frequency [
	^self task frequency
]

{ #category : #accessing }
TkThread >> frequency: newFrequency [
	self task frequency: newFrequency
]

{ #category : #initialization }
TkThread >> initialize [
	super initialize.
	self priority: self defaultPriority.
	self enableFinalization.
	automaton := SmAutomaton new.
	newThreadState := self newState: TkNewThreadState.
	automaton initialState: newThreadState.
	stoppedState := self newState: TkStoppedThreadState.
	startedState := self newState: TkStartedThreadState.
	startedState
		addEntryAction: [self startProcess];
		mainActionBlock: [ self stepTask ].
	killedState := self newState: TkKilledThreadState.
	doneState := self newState: TkDoneThreadState.
	newThreadState transitionTo: startedState.
	stoppedState transitionTo: startedState.
	startedState transitionTo: stoppedState when: [self isStopRequested].
	startedState transitionTo: killedState when: [ self isProcessTerminated ].	
	startedState transitionTo: doneState when: [ self isTaskDone ].	
	killedState transitionTo: startedState.
	doneState transitionTo: startedState.
	
]

{ #category : #testing }
TkThread >> isDone [
	^self state isDone
]

{ #category : #initialization }
TkThread >> isFinalizationEnabled [
	^isFinalizationEnabled
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
	self step.

]

{ #category : #accessing }
TkThread >> name [
	^ name ifNil: [ self defaultName ]
]

{ #category : #accessing }
TkThread >> name: aString [
	name := aString.
	self process ifNil: [ ^self ].
	self process name: aString.
]

{ #category : #initialization }
TkThread >> newState: stateClass [
	| newState |
	newState := automaton newState: stateClass.
	newState thread: self.
	^newState
]

{ #category : #accessing }
TkThread >> period [
	^self task
]

{ #category : #accessing }
TkThread >> period: aDuration [ 
	self task period: aDuration
]

{ #category : #living }
TkThread >> persistUntillDone [
	self disableFinalization
]

{ #category : #accessing }
TkThread >> priority [
	^ priority
]

{ #category : #accessing }
TkThread >> priority: newPriority [
	priority := newPriority.
	self process ifNil: [ ^self ].
	self process priority: newPriority.
]

{ #category : #accessing }
TkThread >> process [
	^process
]

{ #category : #accessing }
TkThread >> resetBlock [
	^self task resetBlock
]

{ #category : #initialization }
TkThread >> resetBlock: aBlock [
	self task resetBlock: aBlock
]

{ #category : #living }
TkThread >> resetTask [
	self task reset
]

{ #category : #living }
TkThread >> restart [
	^self state restart
]

{ #category : #accessing }
TkThread >> setUpBlock [
	^self task setUpBlock
]

{ #category : #accessing }
TkThread >> setUpBlock: aBlock [
	self task setUpBlock: aBlock
]

{ #category : #living }
TkThread >> start [
	^self state start
]

{ #category : #living }
TkThread >> startAfter: aDuration [
	self task actAfter: aDuration.
	self start.
]

{ #category : #living }
TkThread >> startOn: aDateAndTime [
	self task actOn: aDateAndTime.
	self start.
]

{ #category : #living }
TkThread >> startProcess [
	self isStopRequested: false.
	process := [ self loop ] newProcess.
	process priority: self priority.
	process name: self name.
	process resume
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
	self waitUntilTaskIsDue.
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

{ #category : #accessing }
TkThread >> tearDownBlock [
	^self task tearDownBlock
]

{ #category : #accessing }
TkThread >> tearDownBlock: aBlock [
	self task tearDownBlock: aBlock
]

{ #category : #living }
TkThread >> terminateProcess [
	self process terminate
]

{ #category : #living }
TkThread >> waitDone [
	^self waitDoneTimeout: self defaultWaitDoneTimoutDuration
]

{ #category : #living }
TkThread >> waitDoneTimeout: aDuration [
	| semaphore |
	semaphore := Semaphore new.
	doneState addEntryAction: [semaphore signal].
	semaphore wait: aDuration
]

{ #category : #living }
TkThread >> waitUntilTaskIsDue [
	self task isDue ifTrue: [ ^self ].
	self task durationToDueTime wait
]
