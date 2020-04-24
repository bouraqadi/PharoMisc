Class {
	#name : #TkOneShotTaskTest,
	#superclass : #TkTaskTest,
	#category : #'Tasks-Tests'
}

{ #category : #tests }
TkOneShotTaskTest >> testOneShotTask [
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
TkOneShotTaskTest >> testResetOneShotTask [
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
TkOneShotTaskTest >> testSetStartTimeInTheFuture [
	task :=  bench taskOneShot.
	bench setStartTime100MillisecondsInTheFuture.
	self deny: task isDue.
	self deny: task isDone.
	100 milliSeconds wait.
	self assert: task isDue.
	self deny: task isDone.
	
]

{ #category : #tests }
TkOneShotTaskTest >> testSetStartTimeInThePast [
	task :=  bench taskOneShot.
	bench setStartTime100MillisecondsInThePast.
	self assert: task isDue.
	self deny: task isDone.

]
