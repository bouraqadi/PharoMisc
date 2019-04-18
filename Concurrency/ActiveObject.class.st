"
An ActiveObject is an Object that drives a process to perform some action block. Note that an active object has a name that is attached to its process. So, it's easier to track on the process Browser.

Examples are provided as class side methods of ActiveObjectExamples
 
Instance Variables
	process:		<Process>
	actionBlock:		<activityBlock> action to be performed by the active object within the process
	activityLock:		<Mutex> for synchronizing start and stop
	name:		<String> process name
	priority:		<Integer> process priority


"
Class {
	#name : #ActiveObject,
	#superclass : #Object,
	#instVars : [
		'process',
		'activityBlock',
		'activityLock',
		'priority',
		'name'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #private }
ActiveObject class >> blockForRepeating: aBlockClosure every: aDuration [
	^ [ 
	| delay |
	delay := aDuration asDelay.
	[ 
	aBlockClosure value.
	aDuration wait ] repeat ]
]

{ #category : #private }
ActiveObject class >> blockForRepeating: stepBlock every: aDuration while: conditionBlock [
	^ [ 
	| delay |
	delay := aDuration asDelay.
	conditionBlock whileTrue: [ 
		stepBlock value.
		aDuration wait ] 
	]
]

{ #category : #'instance-creation' }
ActiveObject class >> do: taskBlock [
	^self new
		activityBlock: taskBlock;
		yourself
]

{ #category : #'instance-creation' }
ActiveObject class >> do: taskBlock ensure: cleanupBlock [ 
	^self do: [taskBlock ensure: cleanupBlock]
]

{ #category : #'instance-creation' }
ActiveObject class >> do: initBlock thenRepeat: loopBlock [
	^self do: [
		initBlock value.
		loopBlock repeat
		]
]

{ #category : #'instance-creation' }
ActiveObject class >> do: initBlock thenRepeat: loopBlock ensure: cleanupBlock [
	^self 
		do: [
			initBlock value.
			loopBlock repeat] 
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
ActiveObject class >> do: initBlock thenRepeat: stepBlock every: aDuration [ 
	^self do: [
		initBlock value.
		(self blockForRepeating: stepBlock every: aDuration) value
		]
]

{ #category : #'instance-creation' }
ActiveObject class >> do: initBlock thenRepeat: stepBlock every: aDuration ensure: cleanUpBlock [
	^self 
		do: [
			initBlock value.
			(self blockForRepeating: stepBlock every: aDuration) value
		]ensure: cleanUpBlock
]

{ #category : #'instance-creation' }
ActiveObject class >> do: initBlock thenRepeat:  taskBlock every: aDuration while: conditionBlock [ 
	^self 
		do:[
			initBlock value. 
			(self blockForRepeating: taskBlock every: aDuration while: conditionBlock) value]

]

{ #category : #'instance-creation' }
ActiveObject class >> do: initBlock thenRepeat:  taskBlock every: aDuration while: conditionBlock ensure: cleanupBlock [
	^self 
		do:[
			initBlock value. 
			(self blockForRepeating: taskBlock every: aDuration while: conditionBlock) value]
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock [
	^self do: [ taskBlock repeat ]
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock  ensure: cleanupBlock [
	^self 
		do: [ taskBlock repeat ]
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock every: aDuration [
	^ self do: (self blockForRepeating: taskBlock every: aDuration)
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock every: aDuration ensure: cleanupBlock [
	^self 
		do: (self blockForRepeating: taskBlock every: aDuration)
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock every: aDuration while: conditionBlock [
	^self do: (self blockForRepeating: taskBlock every: aDuration while: conditionBlock)
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock every: aDuration while: conditionBlock ensure: cleanupBlock [
	^self 
		do: (self blockForRepeating: taskBlock every: aDuration while: conditionBlock)
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock while: conditionBlock [
	^self do: [ conditionBlock whileTrue: taskBlock ]
]

{ #category : #'instance-creation' }
ActiveObject class >> repeat: taskBlock while: conditionBlock  ensure: cleanupBlock [
	^self 
		do: [ conditionBlock whileTrue: taskBlock ]
		ensure: cleanupBlock
]

{ #category : #accessing }
ActiveObject >> activityBlock [
	^ activityBlock
]

{ #category : #accessing }
ActiveObject >> activityBlock: aBlock [
	activityBlock := aBlock 
]

{ #category : #'initailize-release' }
ActiveObject >> defaultName [
	^'anActiveObject'
]

{ #category : #'initailize-release' }
ActiveObject >> defaultPriority [
	^30
]

{ #category : #finalization }
ActiveObject >> finalize [
	self stop
]

{ #category : #'testing-private' }
ActiveObject >> ifProcessAlive: blockForLiveProcess ifDead: blockForDeadProcess [
	"WARNING: Low-level use ifStarted:ifStoped: instead"
	activityLock critical: [
		process ifNil: [ ^blockForDeadProcess value ].
		process isTerminated ifTrue:  [ ^blockForDeadProcess value ].
		^blockForLiveProcess value]
]

{ #category : #testing }
ActiveObject >> ifStarted: aBlock [ 
	^self 
		ifStarted: aBlock
		ifStopped: self 
]

{ #category : #testing }
ActiveObject >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^self ifProcessAlive: blockForStarted ifDead: blockForStopped 
]

{ #category : #testing }
ActiveObject >> ifStopped: aBlock [ 
	^self 
		ifStarted:  self 
		ifStopped: aBlock 
]

{ #category : #'initailize-release' }
ActiveObject >> initialize [
	super initialize.
	activityLock := Mutex new.
	self name: self defaultName.
	self priority: self defaultPriority
]

{ #category : #testing }
ActiveObject >> isStarted [
	^self 
		ifStarted: [ true ] 
		ifStopped: [false] 
]

{ #category : #testing }
ActiveObject >> isStopped [
	^self 
		ifStarted: [ false ] 
		ifStopped: [true] 
]

{ #category : #accessing }
ActiveObject >> name [
	^ name
]

{ #category : #accessing }
ActiveObject >> name: aString [
	name := aString.
	self ifStopped: [^self].
	process name: self name
]

{ #category : #accessing }
ActiveObject >> priority [
	^ priority
]

{ #category : #accessing }
ActiveObject >> priority: newPriority [
	priority := newPriority.
	self ifStopped: [^self].
	process priority: self priority
]

{ #category : #accessing }
ActiveObject >> process [
	^process
]

{ #category : #finalization }
ActiveObject >> registerForFinalization [
	self finalizationRegistry add: self
]

{ #category : #acting }
ActiveObject >> runTillDone [
	[self start] fork
]

{ #category : #acting }
ActiveObject >> start [
	"The process (i.e. the activityBlock) MUST NOT have any reference to the active object (self) to enable finalization"
	"This is because processes are never GCed unless they are terminated.
	And we want force stopping the active object i.e. terminate the process once the active object reference is forgotten"
	self ifStopped: [ 
		process := self activityBlock newProcess.
		process priority: self priority.
		process name: self name.
		self registerForFinalization.
		process resume
	]
]

{ #category : #acting }
ActiveObject >> stop [
	self ifStarted: [
		process terminate.
	]
	
]
