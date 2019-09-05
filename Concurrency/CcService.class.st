"
A service drives a low-level process to perform some action block. Note that a some has a name that is attached to its process. So, it's easier to track on the Process Browser.

Examples are provided as class side methods of CcServiceExamples
 
Instance Variables
	process:		<Process>
	activityBlock		<BlockClosure> action to be performed within the process
	ensureBlock		<BlockClosure> action to be performed upon the process thermination
	lock		<Semaphore> for synchronizing start and stop
	name:		<String> process name
	priority:		<Integer> process priority
	processStartTimeoutMilliseconds <Integer> duration to wait before saying something went wrong upon start up.
	processStartSemaphore <Semaphore> Signaled when process is started
	processStopTimeoutMilliseconds <Integer> duration to wait before saying something went wrong upon stopping.
	processStopSemaphore <Semaphore> Signaled when process is stopped
	runner <ServiceRunner> takes care of process lifecycle as well as issuing notifications when state actually changed.
	state <ServiceState> defines the service behavior depending on its state. As defined by the State Design Pattern
	
	


"
Class {
	#name : #CcService,
	#superclass : #Object,
	#instVars : [
		'activityBlock',
		'ensureBlock',
		'priority',
		'name',
		'state',
		'runner',
		'lock',
		'processStartTimeoutMilliseconds',
		'processStopTimeoutMilliseconds',
		'processStartSemaphore',
		'processStopSemaphore'
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
	^self do: taskBlock ensure: [  ]
]

{ #category : #'instance-creation' }
CcService class >> do: taskBlock ensure: cleanupBlock [ 
	^self new
		activityBlock: taskBlock;
		ensureBlock: cleanupBlock;
		yourself

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
	^'a Service'
]

{ #category : #'initialize-release' }
CcService >> defaultPriority [
	^30
]

{ #category : #'initialize-release' }
CcService >> defaultProcessStartTimeoutMilliseconds [
	^500
]

{ #category : #'initialize-release' }
CcService >> defaultProcessStopTimeoutMilliseconds [
	^self defaultProcessStartTimeoutMilliseconds
]

{ #category : #accessing }
CcService >> ensureBlock [
	^ ensureBlock
]

{ #category : #accessing }
CcService >> ensureBlock: anObject [
	ensureBlock := anObject
]

{ #category : #finalization }
CcService >> finalize [
	self runner stop
]

{ #category : #testing }
CcService >> ifStarted: aBlock [ 
	^self 
		ifStarted: aBlock
		ifStopped: self 
]

{ #category : #testing }
CcService >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	^lock critical: [self state ifStarted: blockForStarted ifStopped: blockForStopped] 
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
	lock := Semaphore forMutualExclusion.
	processStartSemaphore := Semaphore new.
	processStopSemaphore := Semaphore new.
	processStartTimeoutMilliseconds := self defaultProcessStartTimeoutMilliseconds.
	processStopTimeoutMilliseconds := self defaultProcessStopTimeoutMilliseconds.
	self state: CcStopped new.
	self name: self defaultName.
	self priority: self defaultPriority.
	runner := self serviceRunnerClass new.
	runner service: self.
	self registerForFinalization.
]

{ #category : #testing }
CcService >> isStarted [
	^self ifStarted: [ true ] ifStopped: [ false ]
]

{ #category : #testing }
CcService >> isStopped [
	^self ifStarted: [ false ] ifStopped: [ true ]
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

{ #category : #acting }
CcService >> onProcessStarted [
	self state onProcessStarted
]

{ #category : #acting }
CcService >> onProcessStopped [
	self state onProcessStopped.

]

{ #category : #printing }
CcService >> printOn: aStream [
	aStream
		<< self name;
		space;
		<< $(;
		<< self stateString;
		<< $)
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

{ #category : #accessing }
CcService >> processStartTimeoutMilliseconds [
	^processStartTimeoutMilliseconds
]

{ #category : #accessing }
CcService >> processStartTimeoutMilliseconds: anObject [
	processStartTimeoutMilliseconds := anObject
]

{ #category : #accessing }
CcService >> processStopTimeoutMilliseconds [
	^processStopTimeoutMilliseconds
]

{ #category : #accessing }
CcService >> processStopTimeoutMilliseconds: anObject [
	processStopTimeoutMilliseconds := anObject
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
CcService >> signalProcessStarted [
	processStartSemaphore signal
]

{ #category : #acting }
CcService >> signalProcessStopped [
	processStopSemaphore signal
]

{ #category : #acting }
CcService >> start [
	lock critical: [
		self state start].

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

{ #category : #printing }
CcService >> stateString [
	^self state stateString
]

{ #category : #acting }
CcService >> stop [
	lock critical: [
		self state stop].

]

{ #category : #acting }
CcService >> waitProcessStarted [
	processStartSemaphore waitTimeoutMSecs: self processStartTimeoutMilliseconds
]

{ #category : #acting }
CcService >> waitProcessStopped [
	processStopSemaphore waitTimeoutMSecs: self processStopTimeoutMilliseconds
]
