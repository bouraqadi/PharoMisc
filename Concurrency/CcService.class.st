"
A service drives a low-level process to perform some action block. Note that a some has a name that is attached to its process. So, it's easier to track on the Process Browser.

Examples are provided as class side methods of CcServiceExamples
 
Instance Variables
	process:		<Process>
	actionBlock:		<activityBlock> action to be performed by the active object within the process
	activityLock:		<Mutex> for synchronizing start and stop
	name:		<String> process name
	priority:		<Integer> process priority


"
Class {
	#name : #CcService,
	#superclass : #Object,
	#instVars : [
		'process',
		'activityBlock',
		'priority',
		'name',
		'state',
		'runner'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #private }
CcService class >> blockForRepeating: aBlockClosure every: aDuration [
	^ [ 
	| delay |
	delay := aDuration asDelay.
	[ 
	aBlockClosure value.
	aDuration wait ] repeat ]
]

{ #category : #private }
CcService class >> blockForRepeating: stepBlock every: aDuration while: conditionBlock [
	^ [ 
	| delay |
	delay := aDuration asDelay.
	conditionBlock whileTrue: [ 
		stepBlock value.
		aDuration wait ] 
	]
]

{ #category : #'instance-creation' }
CcService class >> do: taskBlock [
	^self new
		activityBlock: taskBlock;
		yourself
]

{ #category : #'instance-creation' }
CcService class >> do: taskBlock ensure: cleanupBlock [ 
	^self do: [taskBlock ensure: cleanupBlock]
]

{ #category : #'instance-creation' }
CcService class >> do: initBlock thenRepeat: loopBlock [
	^self do: [
		initBlock value.
		loopBlock repeat
		]
]

{ #category : #'instance-creation' }
CcService class >> do: initBlock thenRepeat: loopBlock ensure: cleanupBlock [
	^self 
		do: [
			initBlock value.
			loopBlock repeat] 
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcService class >> do: initBlock thenRepeat: stepBlock every: aDuration [ 
	^self do: [
		initBlock value.
		(self blockForRepeating: stepBlock every: aDuration) value
		]
]

{ #category : #'instance-creation' }
CcService class >> do: initBlock thenRepeat: stepBlock every: aDuration ensure: cleanUpBlock [
	^self 
		do: [
			initBlock value.
			(self blockForRepeating: stepBlock every: aDuration) value
		]ensure: cleanUpBlock
]

{ #category : #'instance-creation' }
CcService class >> do: initBlock thenRepeat:  taskBlock every: aDuration while: conditionBlock [ 
	^self 
		do:[
			initBlock value. 
			(self blockForRepeating: taskBlock every: aDuration while: conditionBlock) value]

]

{ #category : #'instance-creation' }
CcService class >> do: initBlock thenRepeat:  taskBlock every: aDuration while: conditionBlock ensure: cleanupBlock [
	^self 
		do:[
			initBlock value. 
			(self blockForRepeating: taskBlock every: aDuration while: conditionBlock) value]
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock [
	^self do: [ taskBlock repeat ]
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock  ensure: cleanupBlock [
	^self 
		do: [ taskBlock repeat ]
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock every: aDuration [
	^ self do: (self blockForRepeating: taskBlock every: aDuration)
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock every: aDuration ensure: cleanupBlock [
	^self 
		do: (self blockForRepeating: taskBlock every: aDuration)
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock every: aDuration while: conditionBlock [
	^self do: (self blockForRepeating: taskBlock every: aDuration while: conditionBlock)
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock every: aDuration while: conditionBlock ensure: cleanupBlock [
	^self 
		do: (self blockForRepeating: taskBlock every: aDuration while: conditionBlock)
		ensure: cleanupBlock
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock while: conditionBlock [
	^self do: [ conditionBlock whileTrue: taskBlock ]
]

{ #category : #'instance-creation' }
CcService class >> repeat: taskBlock while: conditionBlock  ensure: cleanupBlock [
	^self 
		do: [ conditionBlock whileTrue: taskBlock ]
		ensure: cleanupBlock
]

{ #category : #accessing }
CcService >> activityBlock [
	^ activityBlock
]

{ #category : #accessing }
CcService >> activityBlock: aBlock [
	activityBlock := aBlock
]

{ #category : #'initialize-release' }
CcService >> defaultName [
	^self printString
]

{ #category : #'initialize-release' }
CcService >> defaultPriority [
	^30
]

{ #category : #finalization }
CcService >> finalize [
	self stop
]

{ #category : #testing }
CcService >> ifStarted: aBlock [ 
	^self 
		ifStarted: aBlock
		ifStopped: self 
]

{ #category : #testing }
CcService >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^self state ifStarted: blockForStarted ifStopped: blockForStopped 
]

{ #category : #testing }
CcService >> ifStopped: aBlock [ 
	^self 
		ifStarted:  self 
		ifStopped: aBlock 
]

{ #category : #'initialize-release' }
CcService >> initialize [
	super initialize.
	self state: CcStopped new.
	self name: self defaultName.
	self priority: self defaultPriority.
	runner := self serviceRunnerClass new.
	runner service: self.
	self registerForFinalization.

]

{ #category : #testing }
CcService >> isStarted [
	^self state isStarted
]

{ #category : #testing }
CcService >> isStopped [
	^self state isStopped

]

{ #category : #accessing }
CcService >> name [
	^ name
]

{ #category : #accessing }
CcService >> name: aString [
	name := aString.
	self state name: aString
]

{ #category : #accessing }
CcService >> priority [
	^ priority
]

{ #category : #accessing }
CcService >> priority: newPriority [
	priority := newPriority.
	self state priority: newPriority
]

{ #category : #accessing }
CcService >> process [
	^self runner process
]

{ #category : #finalization }
CcService >> registerForFinalization [
	self finalizationRegistry add: self
]

{ #category : #acting }
CcService >> runTillDone [
	[self start] fork
]

{ #category : #accessing }
CcService >> runner [
	^runner
]

{ #category : #'initialize-release' }
CcService >> serviceRunnerClass [
	^CcServiceRunner
]

{ #category : #acting }
CcService >> start [
	self state start
]

{ #category : #accessing }
CcService >> state [
	^ state
]

{ #category : #accessing }
CcService >> state: aState [
	state := aState.
	state service: self.

]

{ #category : #acting }
CcService >> stop [
	self state stop
]
