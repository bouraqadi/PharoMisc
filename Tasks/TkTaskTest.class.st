Class {
	#name : #TkTaskTest,
	#superclass : #TestCase,
	#instVars : [
		'bench',
		'task'
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
	task :=  bench taskOneShot.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 0.
	task step.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 1.
	2 timesRepeat: [
		task step.
		self deny: task isDue.
		self assert: task isDone.
		self assert: bench actionCount equals: 1
	].
	
	
]

{ #category : #tests }
TkTaskTest >> testResetOneShotTask [
	task := bench taskOneShot.
	2 timesRepeat: [task step].
	self deny: task isDue.
	self assert: task isDone.
	task reset.
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [task step].
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 2.
	
	
]

{ #category : #tests }
TkTaskTest >> testResetTaskDoneRepeatingForFixedIterationsCount [
	task := bench taskRepeating3Times.
	4 timesRepeat: [task step].
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 3.
	task reset.
	self assert: task isDue.
	self deny: task isDone.
	4 timesRepeat: [task step].
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 6.
	self assert: bench resetCount equals: 1.
]

{ #category : #tests }
TkTaskTest >> testResetTaskRepeatingForever [
	task := bench taskRepeatingForever.
	bench addSetUpBlock.
	task step.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	task reset.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 1.
	self assert: bench resetCount equals: 1.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 1.
	task step.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 2.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 1.
	task step.
	self assert: bench actionCount equals: 1.
	self assert: bench setUpCount equals: 2.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 1.
	task reset.
	self assert: bench actionCount equals: 1.
	self assert: bench setUpCount equals: 2.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 2.
	task step.
	self assert: bench actionCount equals: 1.
	self assert: bench setUpCount equals: 3.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 2.

]

{ #category : #tests }
TkTaskTest >> testResetTaskRepeatingUntilConditionMet [
	task := bench taskRepeatingUntilFlagTrue.
	bench addTearDownBlock.
	task step.
	self assert: bench actionCount equals: 1.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	task reset.
	self assert: bench actionCount equals: 1.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 1.
	task step.
	self assert: bench actionCount equals: 2.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 1.
	bench setFlagTrue.
	task step.
	self assert: bench actionCount equals: 2.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 1.
	self assert: bench resetCount equals: 1.
	task step.
	self deny: task isDue.
	self assert: task isDone.
	task reset.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 2.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 1.
	self assert: bench resetCount equals: 2.


]

{ #category : #tests }
TkTaskTest >> testSetUpTaskRepeatingForever [
	task := bench taskRepeatingForever.
	bench addSetUpBlock.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	task step.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	1 to: 3 do: [: expectedCount |
		task step.
		self assert: task isDue.
		self deny: task isDone.
		self assert: bench actionCount equals: expectedCount.
		self assert: bench setUpCount equals: 1.
		self assert: bench tearDownCount equals: 0.
		self assert: bench resetCount equals: 0.
	].

]

{ #category : #tests }
TkTaskTest >> testSetUpTaskRepeatingUntilConditionMet [
	task := bench taskRepeatingUntilFlagTrue.
	bench addSetUpBlock.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	task step.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	1 to: 2 do: [ : expectedCount |
		task step.
		self assert: task isDue.
		self deny: task isDone.
		self assert: bench actionCount equals: expectedCount.
		self assert: bench setUpCount equals: 1.
		self assert: bench tearDownCount equals: 0.
		self assert: bench resetCount equals: 0.
	].
	bench setFlagTrue.
	task step.
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 2.
	self assert: bench setUpCount equals: 1.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.


]

{ #category : #tests }
TkTaskTest >> testTaskDoneRepeatingForFixedIterationsCount [
	task := bench taskRepeating3Times.
	self assert: bench actionCount equals: 0.
	1 to: 3 do: [: expectedCount |
		self assert: task isDue.
		self deny: task isDone.
		task step.
		self assert: bench actionCount equals: expectedCount.
	].
	self assert: task isDue.
	self deny: task isDone.
	task step.
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 3.
	
	
]

{ #category : #tests }
TkTaskTest >> testTaskRepeatingForever [
	task := bench taskRepeatingForever.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	1 to: 3 do: [ : expectedCount |
		task step.
		self assert: task isDue.
		self deny: task isDone.
		self assert: bench actionCount equals: expectedCount.
		self assert: bench setUpCount equals: 0.
		self assert: bench tearDownCount equals: 0.
		self assert: bench resetCount equals: 0.
	]
]

{ #category : #tests }
TkTaskTest >> testTaskRepeatingUntilConditionMet [
	task := bench taskRepeatingUntilFlagTrue.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.
	1 to: 2 do: [ : expectedCount |
		task step.
		self assert: task isDue.
		self deny: task isDone.
		self assert: bench actionCount equals: expectedCount.
		self assert: bench setUpCount equals: 0.
		self assert: bench tearDownCount equals: 0.
		self assert: bench resetCount equals: 0.
	].
	bench setFlagTrue.
	task step.
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 2.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.


]

{ #category : #tests }
TkTaskTest >> testTearDownTaskRepeatingUntilConditionMet [
	task := bench taskRepeatingUntilFlagTrue.
	bench addTearDownBlock.
	2 timesRepeat: [task step].
	bench setFlagTrue.
	task step.
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [
		task step.
		self deny: task isDue.
		self assert: task isDone.
		self assert: bench actionCount equals: 2.
		self assert: bench setUpCount equals: 0.
		self assert: bench tearDownCount equals: 1.
	]

]
