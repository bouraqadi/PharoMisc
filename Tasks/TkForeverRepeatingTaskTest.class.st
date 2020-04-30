Class {
	#name : #TkForeverRepeatingTaskTest,
	#superclass : #TkTaskTest,
	#category : #'Tasks-Tests'
}

{ #category : #tests }
TkForeverRepeatingTaskTest >> testPostponeAfterStart [
	task := bench taskRepeatingForever.
	task step. "Act"
	bench postponeActionBy100Milliseconds.
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [
		task step. "Act"
		self assert: task isDue.
		self deny: task isDone
	].
	
]

{ #category : #tests }
TkForeverRepeatingTaskTest >> testPostponeStart [
	task := bench taskRepeatingForever.
	self assert: task isDue.
	self deny: task isDone.
	bench postponeActionBy100Milliseconds.
	self deny: task isDue.
	self deny: task isDone.
	100 milliSeconds wait. "Ensure start delay passed"
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [
		task step. "Act"
		self assert: task isDue.
		self deny: task isDone
	].
	
]

{ #category : #tests }
TkForeverRepeatingTaskTest >> testResetAfterPostponedStart [
	task := bench taskRepeatingForever.
	bench postponeActionBy100Milliseconds.
	self deny: task isDue.
	self deny: task isDone.
	100 milliSeconds wait. "Ensure start delay passed"
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [
		task step. "Act"
	].
	task reset.
	self assert: task isDue.
	self deny: task isDone.
	
]

{ #category : #tests }
TkForeverRepeatingTaskTest >> testResetAfterPostponedStartPeriod100Milliseconds [
	task := bench taskRepeatingForeverPeriod100Milliseconds.
	bench postponeActionBy100Milliseconds.
	self deny: task isDue.
	self deny: task isDone.
	100 milliSeconds wait. "Ensure start delay passed"
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [
		task step. "Act"
		100 milliSeconds wait. "Ensure task is due"
	].
	task reset.
	self assert: task isDue.
	self deny: task isDone.
	
]

{ #category : #tests }
TkForeverRepeatingTaskTest >> testResetTaskRepeatingForever [
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
TkForeverRepeatingTaskTest >> testResetTaskRepeatingForeverBeforeFirstStep [
	task := bench taskRepeatingForever.
	bench addSetUpBlock.
	task reset.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 0.
	self assert: bench resetCount equals: 1.
	task step.
	self assert: bench actionCount equals: 0.
	self assert: bench setUpCount equals: 1.
	self assert: bench resetCount equals: 1.
	task step.
	self assert: bench actionCount equals: 1.
	self assert: bench setUpCount equals: 1.
	self assert: bench resetCount equals: 1.
	
]

{ #category : #tests }
TkForeverRepeatingTaskTest >> testSetUpTaskRepeatingForever [
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
TkForeverRepeatingTaskTest >> testTaskRepeatingForever [
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
TkForeverRepeatingTaskTest >> testTaskRepeatingForeverPeriod100Milliseconds [
	task := bench taskRepeatingForeverPeriod100Milliseconds.
	self assert: task isDue.
	2 timesRepeat: [
		task step.
		self deny: task isDue.
		100 milliSeconds wait.
		self assert: task isDue
	].
	
]
