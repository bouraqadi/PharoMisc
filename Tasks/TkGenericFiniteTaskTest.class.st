Class {
	#name : #TkGenericFiniteTaskTest,
	#superclass : #TkTaskTest,
	#category : #'Tasks-Tests'
}

{ #category : #tests }
TkGenericFiniteTaskTest >> testResetPostponedStartWithSetupTearDownBlocks [
	task := bench taskRepeatingUntilFlagTrue.
	bench addSetUpTearDownBlocks.
	bench postponeStartBy100Milliseconds.
	100 milliSeconds wait.
	self assert: task isDue.
	task step. "SetUp"
	task step. "Act"
	bench setFlagTrue.
	task step. "TearDown"
	task step. "DONE"
	self deny: task isDue.
	self assert: task isDone.
	task reset.
	self assert: task isDue.
	self deny: task isDone.

]

{ #category : #tests }
TkGenericFiniteTaskTest >> testResetTaskRepeatingUntilConditionMet [
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
TkGenericFiniteTaskTest >> testSetUpTaskRepeatingUntilConditionMet [
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
TkGenericFiniteTaskTest >> testTaskRepeatingUntilConditionMet [
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
TkGenericFiniteTaskTest >> testTaskRepeatingUntilConditionMetPeriod100Milliseconds [
	task := bench taskRepeatingUntilFlagTruePeriod100Milliseconds.
	self assert: task isDue.	
	2 timesRepeat: [
		task step.
		self deny: task isDue.
		100 milliSeconds wait.
		self assert: task isDue
	].
	bench setFlagTrue.
	task step.
	self deny: task isDue.
	self assert: task isDone.

]

{ #category : #tests }
TkGenericFiniteTaskTest >> testTaskRepeatingWhileConditionMet [
	task := bench taskRepeatingWhileFlagTrue.
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
	bench setFlagFalse.
	task step.
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 2.
	self assert: bench setUpCount equals: 0.
	self assert: bench tearDownCount equals: 0.
	self assert: bench resetCount equals: 0.


]

{ #category : #tests }
TkGenericFiniteTaskTest >> testTearDownTaskRepeatingUntilConditionMet [
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

{ #category : #tests }
TkGenericFiniteTaskTest >> testTearDownTaskRepeatingUntilConditionMetPeriod100Milliseconds [
	task := bench taskRepeatingUntilFlagTruePeriod100Milliseconds.
	bench addTearDownBlock.
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [
		task step.
		self deny: task isDue.
		100 milliSeconds wait.
		self assert: task isDue
	].
	bench setFlagTrue.
	task step.
	self assert: task isDue.
	self deny: task isDone.
	task step.
	self deny: task isDue.
	self assert: task isDone.

]
