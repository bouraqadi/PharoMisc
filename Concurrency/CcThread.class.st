"
A CcThread is an Object that drives a low-level process to perform some action block. Note that an thread has a name that is attached to its process. So, it's easier to track on the process Browser.

Examples are provided as class side methods of CcThreadExamples
 
Instance Variables
	process:		<Process>
	actionBlock:		<activityBlock> action to be performed by the active object within the process
	activityLock:		<Mutex> for synchronizing start and stop
	name:		<String> process name
	priority:		<Integer> process priority


"
Class {
	#name : #CcThread,
	#superclass : #Object,
	#instVars : [
		'process',
		'activityBlock',
		'activityLock',
		'priority',
		'name',
		'state'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #private }
CcThread class >> blockForRepeating: aBlockClosure every: aDuration [
	^ [ 
	| delay |
	delay := aDuration asDelay.
	[ 
	aBlockClosure value.
	aDuration wait ] repeat ]
]

{ #category : #private }
CcThread class >> blockForRepeating: stepBlock every: aDuration while: conditionBlock [
	^ [ 
	| delay |
	delay := aDuration asDelay.
	conditionBlock whileTrue: [ 
		stepBlock value.
		aDuration wait ] 
	]
]

{ #category : #'instance-creation' }
CcThread class >> do: taskBlock [
	^self new
		activityBlock: taskBlock;
		yourself
]

{ #category : #'instance-creation' }
CcThread class >> do: taskBlock ensure: cleanupBlock [ 
	^self do: [taskBlock ensure: cleanupBlock]
]

{ #category : #'instance-creation' }
CcThread class >> do: initBlock thenRepeat: loopBlock [
	^self do: [
		initBlock value.
		loopBlock repeat
		]
]

{ #category : #'instance-creation' }
CcThread class >> do: initBlock thenRepeat: loopBlock ensure: cleanupBlock [
	^self 
		do: [
			initBlock value.
			loopBlock repeat] 
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcThread class >> do: initBlock thenRepeat: stepBlock every: aDuration [ 
	^self do: [
		initBlock value.
		(self blockForRepeating: stepBlock every: aDuration) value
		]
]

{ #category : #'instance-creation' }
CcThread class >> do: initBlock thenRepeat: stepBlock every: aDuration ensure: cleanUpBlock [
	^self 
		do: [
			initBlock value.
			(self blockForRepeating: stepBlock every: aDuration) value
		]ensure: cleanUpBlock
]

{ #category : #'instance-creation' }
CcThread class >> do: initBlock thenRepeat:  taskBlock every: aDuration while: conditionBlock [ 
	^self 
		do:[
			initBlock value. 
			(self blockForRepeating: taskBlock every: aDuration while: conditionBlock) value]

]

{ #category : #'instance-creation' }
CcThread class >> do: initBlock thenRepeat:  taskBlock every: aDuration while: conditionBlock ensure: cleanupBlock [
	^self 
		do:[
			initBlock value. 
			(self blockForRepeating: taskBlock every: aDuration while: conditionBlock) value]
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock [
	^self do: [ taskBlock repeat ]
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock  ensure: cleanupBlock [
	^self 
		do: [ taskBlock repeat ]
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock every: aDuration [
	^ self do: (self blockForRepeating: taskBlock every: aDuration)
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock every: aDuration ensure: cleanupBlock [
	^self 
		do: (self blockForRepeating: taskBlock every: aDuration)
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock every: aDuration while: conditionBlock [
	^self do: (self blockForRepeating: taskBlock every: aDuration while: conditionBlock)
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock every: aDuration while: conditionBlock ensure: cleanupBlock [
	^self 
		do: (self blockForRepeating: taskBlock every: aDuration while: conditionBlock)
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock while: conditionBlock [
	^self do: [ conditionBlock whileTrue: taskBlock ]
]

{ #category : #'instance-creation' }
CcThread class >> repeat: taskBlock while: conditionBlock  ensure: cleanupBlock [
	^self 
		do: [ conditionBlock whileTrue: taskBlock ]
		ensure: cleanupBlock
]

{ #category : #accessing }
CcThread >> activityBlock [
	^ activityBlock
]

{ #category : #accessing }
CcThread >> activityBlock: aBlock [
	activityBlock := aBlock 
]

{ #category : #'initailize-release' }
CcThread >> defaultName [
	^'aThread'
]

{ #category : #'initailize-release' }
CcThread >> defaultPriority [
	^30
]

{ #category : #finalization }
CcThread >> finalize [
	self stop
]

{ #category : #'testing-private' }
CcThread >> ifProcessAlive: blockForLiveProcess ifDead: blockForDeadProcess [
	"WARNING: Low-level use ifStarted:ifStoped: instead"
	activityLock critical: [
		process ifNil: [ ^blockForDeadProcess value ].
		process isTerminated ifTrue:  [ ^blockForDeadProcess value ].
		^blockForLiveProcess value]
]

{ #category : #testing }
CcThread >> ifStarted: aBlock [ 
	^self 
		ifStarted: aBlock
		ifStopped: self 
]

{ #category : #testing }
CcThread >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^self ifProcessAlive: blockForStarted ifDead: blockForStopped 
]

{ #category : #testing }
CcThread >> ifStopped: aBlock [ 
	^self 
		ifStarted:  self 
		ifStopped: aBlock 
]

{ #category : #'initailize-release' }
CcThread >> initialize [
	super initialize.
	activityLock := Mutex new.
	self name: self defaultName.
	self priority: self defaultPriority.
	self state: CcStopped new.
]

{ #category : #testing }
CcThread >> isStarted [
	^self 
		ifStarted: [ true ] 
		ifStopped: [false] 
]

{ #category : #testing }
CcThread >> isStopped [
	^self 
		ifStarted: [ false ] 
		ifStopped: [true] 
]

{ #category : #accessing }
CcThread >> name [
	^ name
]

{ #category : #accessing }
CcThread >> name: aString [
	name := aString.
	self ifStopped: [^self].
	process name: self name
]

{ #category : #acting }
CcThread >> newProcess [
	^self activityBlock newProcess
]

{ #category : #accessing }
CcThread >> priority [
	^ priority
]

{ #category : #accessing }
CcThread >> priority: newPriority [
	priority := newPriority.
	self ifStopped: [^self].
	process priority: self priority
]

{ #category : #accessing }
CcThread >> process [
	^process
]

{ #category : #accessing }
CcThread >> process: aProcess [
	process := aProcess
]

{ #category : #finalization }
CcThread >> registerForFinalization [
	self finalizationRegistry add: self
]

{ #category : #acting }
CcThread >> runTillDone [
	[self start] fork
]

{ #category : #acting }
CcThread >> start [
	self state start
]

{ #category : #accessing }
CcThread >> state [
	^ state
]

{ #category : #accessing }
CcThread >> state: anObject [
	state := anObject
]

{ #category : #acting }
CcThread >> stop [
	self state stop
]
