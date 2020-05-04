"
A thread is a task decorator that ensures the task is run within a dedicated process (instance of Process). Threads are more abstract that tasks and processes. 

Users new to this library should start here. See class side for examples
"
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
	#category : #'Tasks-Public'
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

{ #category : #'initialization-private' }
TkThread >> defaultName [
	^super printString
]

{ #category : #'initialization-private' }
TkThread >> defaultPriority [
	^30
]

{ #category : #'living-private' }
TkThread >> defaultWaitDoneTimoutDuration [
	^3 seconds
]

{ #category : #'living-public' }
TkThread >> disableFinalization [
	isFinalizationEnabled := false
]

{ #category : #'living-public' }
TkThread >> enableFinalization [
	isFinalizationEnabled := true
]

{ #category : #'accessing-public' }
TkThread >> frequency [
	^self task frequency
]

{ #category : #'accessing-public' }
TkThread >> frequency: newFrequency [
	self task frequency: newFrequency
]

{ #category : #'initialization-private' }
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

{ #category : #'testing-public' }
TkThread >> isDone [
	^self state isDone
]

{ #category : #'testing-public' }
TkThread >> isFinalizationEnabled [
	^isFinalizationEnabled
]

{ #category : #'testing-public' }
TkThread >> isKilled [
	^self state isKilled
]

{ #category : #'testing-private' }
TkThread >> isProcessTerminated [
	^self process isTerminated
]

{ #category : #'testing-public' }
TkThread >> isStarted [
	^self state isStarted
]

{ #category : #'testing-private' }
TkThread >> isStopConditionMet [
	^self isStopRequested or: [ self isTaskDone ]

]

{ #category : #'testing-public' }
TkThread >> isStopRequested [
	^ isStopRequested
]

{ #category : #'accessing-private' }
TkThread >> isStopRequested: anObject [
	^ isStopRequested := anObject
]

{ #category : #'testing-public' }
TkThread >> isStopped [
	^self state isStopped
]

{ #category : #'testing-private' }
TkThread >> isTaskDone [
	^self task isDone
]

{ #category : #'living-public' }
TkThread >> kill [
	^self state kill
]

{ #category : #'living-private' }
TkThread >> loop [
	[self isStopConditionMet] whileFalse: [self step].
	self step.

]

{ #category : #'accessing-public' }
TkThread >> name [
	^ name ifNil: [ self defaultName ]
]

{ #category : #'accessing-public' }
TkThread >> name: aString [
	name := aString.
	self process ifNil: [ ^self ].
	self process name: aString.
]

{ #category : #'initialization-private' }
TkThread >> newState: stateClass [
	| newState |
	newState := automaton newState: stateClass.
	newState thread: self.
	^newState
]

{ #category : #'accessing-public' }
TkThread >> period [
	^self task
]

{ #category : #'accessing-public' }
TkThread >> period: aDuration [ 
	self task period: aDuration
]

{ #category : #'living-public' }
TkThread >> persistUntillDone [
	self disableFinalization
]

{ #category : #printing }
TkThread >> printOn: aStream [
	aStream
		<< self name;
		<< ' (';
		print: self priority;
		<< ' - ';
		<< self stateName;
		<< $)
				
		
]

{ #category : #'accessing-public' }
TkThread >> priority [
	^ priority
]

{ #category : #'accessing-public' }
TkThread >> priority: newPriority [
	priority := newPriority.
	self process ifNil: [ ^self ].
	self process priority: newPriority.
]

{ #category : #'accessing-private' }
TkThread >> process [
	^process
]

{ #category : #'accessing-public' }
TkThread >> resetBlock [
	^self task resetBlock
]

{ #category : #'accessing-public' }
TkThread >> resetBlock: aBlock [
	self task resetBlock: aBlock
]

{ #category : #'living-private' }
TkThread >> resetTask [
	self task reset
]

{ #category : #'living-public' }
TkThread >> restart [
	^self state restart
]

{ #category : #'accessing-public' }
TkThread >> setUpBlock [
	^self task setUpBlock
]

{ #category : #'accessing-public' }
TkThread >> setUpBlock: aBlock [
	self task setUpBlock: aBlock
]

{ #category : #'living-public' }
TkThread >> start [
	^self state start
]

{ #category : #'living-public' }
TkThread >> startAfter: aDuration [
	self task actAfter: aDuration.
	self start.
]

{ #category : #'living-public' }
TkThread >> startOn: aDateAndTime [
	self task actOn: aDateAndTime.
	self start.
]

{ #category : #'living-private' }
TkThread >> startProcess [
	self isStopRequested: false.
	process := [ self loop ] newProcess.
	process priority: self priority.
	process name: self name.
	process resume
]

{ #category : #'accessing-private' }
TkThread >> state [
	^ automaton currentState
]

{ #category : #'accessing-private' }
TkThread >> stateName [
	^self state name
]

{ #category : #'living-private' }
TkThread >> step [
	automaton step
]

{ #category : #'living-private' }
TkThread >> stepTask [
	self waitUntilTaskIsDue.
	self task step
]

{ #category : #'living-public' }
TkThread >> stop [
	^self state stop
]

{ #category : #'accessing-private' }
TkThread >> task [
	^ task
]

{ #category : #'accessing-private' }
TkThread >> task: anObject [
	task := anObject
]

{ #category : #'accessing-public' }
TkThread >> tearDownBlock [
	^self task tearDownBlock
]

{ #category : #'accessing-public' }
TkThread >> tearDownBlock: aBlock [
	self task tearDownBlock: aBlock
]

{ #category : #'living-private' }
TkThread >> terminateProcess [
	self process terminate
]

{ #category : #'living-public' }
TkThread >> waitDone [
	^self waitDoneTimeout: self defaultWaitDoneTimoutDuration
]

{ #category : #'living-public' }
TkThread >> waitDoneTimeout: aDuration [
	| semaphore |
	semaphore := Semaphore new.
	doneState addEntryAction: [semaphore signal].
	(semaphore wait: aDuration) ifFalse: [ ^self ]. 
	TkTimeout signal: 'Thread did not finish yet. Current state is : ', self stateName
]

{ #category : #'living-private' }
TkThread >> waitUntilTaskIsDue [
	self task isDue ifTrue: [ ^self ].
	self task durationToDueTime wait
]
