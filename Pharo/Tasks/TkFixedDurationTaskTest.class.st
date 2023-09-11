Class {
	#name : #TkFixedDurationTaskTest,
	#superclass : #TkTaskTest,
	#category : #'Tasks-Tests'
}

{ #category : #tests }
TkFixedDurationTaskTest >> testDoneAfterActingDuring100Milliseconds [
	task := bench taskRepeatingFor100Milliseconds.
	self assert: bench actionCount equals: 0.
	self deny: task isDone.
	self assert: task isDue.
	2 timesRepeat: [task step]. "Act 2 times"
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench actionCount equals: 2.
	100 milliSeconds wait. "Ensure deadline reached"
	task step. "Terminate"
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 2.
	

]

{ #category : #tests }
TkFixedDurationTaskTest >> testDoneAfterActingDuring500Milliseconds [
	task := bench taskRepeatingFor500Milliseconds.
	self assert: bench actionCount equals: 0.
	self deny: task isDone.
	self assert: task isDue.
	5 timesRepeat: [
		task step.
		100 milliSeconds wait]. "Act 5 times until task is done"
	self assert: bench actionCount equals: 5.
	self assert: task isDue.
	self deny: task isDone.
	task step. "Terminate"
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench actionCount equals: 5.
	

]

{ #category : #tests }
TkFixedDurationTaskTest >> testNeverDoneIfNotStarted [
	task := bench taskRepeatingFor100Milliseconds.
	self assert: task isDue.
	self deny: task isDone.
	2 timesRepeat: [
		100 milliSeconds wait.
		self assert: task isDue.
		self deny: task isDone.
	]
	

]

{ #category : #tests }
TkFixedDurationTaskTest >> testResetAfterDone [
	task := bench taskRepeatingFor100Milliseconds.
	task step. "Act"
	100 milliSeconds wait. "Ensure deadline reached"
	task step. "Terminate"
	self deny: task isDue.
	self assert: task isDone.
	self assert: bench resetCount equals: 0.
	task reset.
	self assert: bench resetCount equals: 1.
	self assert: task isDue.
	self deny: task isDone.
	100 milliSeconds wait. 
	self assert: task isDue description: 'Task is due until action is first performed'.
	self deny: task isDone.
	task step. "Act"
	100 milliSeconds wait.
	task step. "Terminate"
	self deny: task isDue.
	self assert: task isDone.

]

{ #category : #tests }
TkFixedDurationTaskTest >> testSetUpTearDown [
	task := bench taskRepeatingFor100Milliseconds.
	bench addSetUpTearDownBlocks.
	self assert: bench setUpCount equals: 0.
	task step. "Do setUp"
	self assert: bench setUpCount equals: 1.
	100 milliSeconds wait. "Stopwatch should not start yet"
	self assert: task isDue.
	self deny: task isDone.
	task step. "Do action + start stopwatch"
	100 milliSeconds wait.
	self assert: task isDue.
	self deny: task isDone.
	self assert: bench tearDownCount equals: 0.
	task step. "Do tearDown"
	self assert: bench tearDownCount equals: 1.
	self assert: bench setUpCount equals: 1.
	self assert: task isDue.
	self deny: task isDone.
	task step. "Terminate"
	self deny: task isDue.
	self assert: task isDone.

]
