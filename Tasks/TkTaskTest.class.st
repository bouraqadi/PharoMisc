Class {
	#name : #TkTaskTest,
	#superclass : #TestCase,
	#instVars : [
		'task',
		'bench'
	],
	#category : #Tasks
}

{ #category : #tests }
TkTaskTest >> setUp [
	super setUp.
	bench := TkTaskTestBench new
]

{ #category : #tests }
TkTaskTest >> testOneShotTask [
	task  := bench taskOneShot.
	self assert: bench count equals: 0.
	self deny: task isDone.
	self deny: task isEndConditionMet.
	task step.
	self assert: bench count equals: 1.
	self assert: task isEndConditionMet.
	task step.
	self assert: bench count equals: 1.
	self assert: task isDone.
	
	
]

{ #category : #tests }
TkTaskTest >> testResetFiniteCountTask [
	task  := bench taskRepeating3TimesWithSetupAndTearDown.
	self assert: bench count equals: 0.
	1 to: 4 do: [: expectedCount |
		task step.
	].
	self assert: task isDone.
	task reset.
	self deny: task isDone.
	4 to: 7 do: [: expectedCount |
		task step.
	].
	self assert: task isDone.
	self assert: bench setUpCount equals: 2.
	self assert: bench tearDownCount equals: 2.

]

{ #category : #tests }
TkTaskTest >> testResetFiniteDurationTask [
	task  := bench taskDoneAfter100MillisecondsWithSetupAndTearDown.
	task step.
	100 milliSeconds wait.
	self assert: bench count equals: 1.
	self assert: task isEndConditionMet.
	self deny: task isDone.
	task reset.
	self deny: task isEndConditionMet.
	task step.
	100 milliSeconds wait.
	self assert: task isEndConditionMet.
	self deny: task isDone.
	task step. "Ensure tearDown"
	self assert: task isDone.	
	self assert: bench count equals: 2.
	self assert: bench setUpCount equals: 2.
	self assert: bench tearDownCount equals: 1. "Reset called before task isDone"

]

{ #category : #tests }
TkTaskTest >> testResetOneShotTask [
	task  := bench taskOneShotWithSetUpTearDown.
	task step.
	self assert: bench count equals: 1.
	self assert: task isEndConditionMet.
	task reset.
	self deny: task isEndConditionMet.
	2 timesRepeat: [task step].
	self assert: bench count equals: 2.
	self assert: task isEndConditionMet.
	self assert: task isDone.
	self assert: bench setUpCount equals: 2.
	self assert: bench tearDownCount equals: 1. "reset performed before reruning "

]

{ #category : #tests }
TkTaskTest >> testResetTaskRepeatingForever [
	task := bench taskRepeatingForeverWithSetup.
	3 timesRepeat: [task step].
	self assert: bench count equals: 3.
	self assert: bench setUpCount equals: 1.
	task reset.
	task step.
	self assert: bench count equals: 4.
	self assert: bench setUpCount equals: 2.

]

{ #category : #tests }
TkTaskTest >> testSetUpTaskRepeatingForever [
	task := bench taskRepeatingForeverWithSetup.
	3 timesRepeat: [task step].
	self assert: bench count equals: 3.
	self assert: bench setUpCount equals: 1.
]

{ #category : #tests }
TkTaskTest >> testSetUpTearDownFiniteCountTask [
	task  := bench taskRepeating3TimesWithSetupAndTearDown.
	self assert: bench count equals: 0.
	1 to: 3 do: [: expectedCount |
		self deny: task isDone.
		task step.
		self assert: bench count equals: expectedCount.
	].
	self assert: task isEndConditionMet.
	self deny: task isDone.
	task step.
	self assert: bench count equals: 3.
	self assert: task isDone.
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 1.
	
	
]

{ #category : #tests }
TkTaskTest >> testSetUpTearDownFiniteDurationTask [
	task  := bench taskDoneAfter100MillisecondsWithSetupAndTearDown.
	200 milliSeconds wait.
	self assert: bench count equals: 0.
	self deny: task isDone.
	task step.
	100 milliSeconds wait.
	task step. "Ensure tearDown"
	self assert: bench count equals: 1.
	self assert: task isDone.
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 1.

]

{ #category : #tests }
TkTaskTest >> testSetUpTearDownOneShotTask [
	task  := bench taskOneShotWithSetUpTearDown.
	self deny: task isDone.
	self assert: bench count equals: 0.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	3 timesRepeat: [task step].
	self assert: task isDone.
	self assert: bench count equals: 1.
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 1.
	
	
]

{ #category : #tests }
TkTaskTest >> testTaskContinuesWhileConditionMet [
	task  := bench taskRepeatingWhileFlagTrue.
	self assert: bench count equals: 0.
	1 to: 3 do: [: expectedCount |
		task step.
		self assert: bench count equals: expectedCount.
		self deny: task isDone.
	].
	bench setFlagFalse.
	self assert: task isEndConditionMet.
	self deny: task isDone.
	task step.
	self assert: bench count equals: 3.
	self assert: task isEndConditionMet.
	self assert: task isDone.

]

{ #category : #tests }
TkTaskTest >> testTaskDoneAfterDurationSinceStart [
	task  := bench taskDoneAfter100Milliseconds.
	200 milliSeconds wait.
	self assert: bench count equals: 0.
	self deny: task isEndConditionMet.
	self deny: task isDone.
	task step.
	100 milliSeconds wait.
	self assert: bench count equals: 1.
	self assert: task isEndConditionMet.
	self deny: task isDone.
	task step.
	self assert: task isDone.

]

{ #category : #tests }
TkTaskTest >> testTaskDoneAfterFixedIterationsCount [
	task  := bench taskRepeating3Times.
	self assert: bench count equals: 0.
	1 to: 3 do: [: expectedCount |
		self deny: task isDone.
		task step.
		self assert: bench count equals: expectedCount.
	].
	self assert: task isEndConditionMet.
	self deny: task isDone.
	3 timesRepeat: [ task step ].
	self assert: bench count equals: 3.
	self assert: task isDone.
	
	
]

{ #category : #tests }
TkTaskTest >> testTaskDoneUntilConditionMet [
	task  := bench taskRepeatingUntilFlagTrue.
	self assert: bench count equals: 0.
	1 to: 3 do: [: expectedCount |
		task step.
		self assert: bench count equals: expectedCount.
		self deny: task isDone.
	].
	bench setFlagTrue.
	task step.
	self assert: bench count equals: 3.

]

{ #category : #tests }
TkTaskTest >> testTaskRepeatingForever [
	task  := bench taskRepeatingForever.
	self assert: bench count equals: 0.
	1 to: 3 do: [: expectedCount |
		self deny: task isDone.
		task step.
		self assert: bench count equals: expectedCount.
	].
	self deny: task isDone.
	
	
]
