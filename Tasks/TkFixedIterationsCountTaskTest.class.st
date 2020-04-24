Class {
	#name : #TkFixedIterationsCountTaskTest,
	#superclass : #TkTaskTest,
	#category : #'Tasks-Tests'
}

{ #category : #tests }
TkFixedIterationsCountTaskTest >> testPeriodFromFrequency [
	task := bench taskRepeating3Times.
	bench setFrequency10Hz.
	self assert: task period equals: 100 milliSeconds.
	bench setPeriod100Milliseconds.
	self assert: task frequency equals: 10
]

{ #category : #tests }
TkFixedIterationsCountTaskTest >> testRepeatingAtGivenFrequency [
	task := bench taskRepeating3Times.
	bench setFrequency10Hz.
	self assert: task isDue.
	task step.
	self deny: task isDue.
	100 milliSeconds wait.
	self assert: task isDue.

]

{ #category : #tests }
TkFixedIterationsCountTaskTest >> testResetTaskDoneRepeatingForFixedIterationsCount [
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
TkFixedIterationsCountTaskTest >> testTaskDoneRepeatingForFixedIterationsCount [
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
