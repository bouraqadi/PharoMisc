Class {
	#name : #TkTaskTestBench,
	#superclass : #TkTestBench,
	#instVars : [
		'task'
	],
	#category : #'Tasks-Tests'
}

{ #category : #creating }
TkTaskTestBench >> addResetBlock [
	task resetBlock: self resetBlock
]

{ #category : #creating }
TkTaskTestBench >> addSetUpBlock [
	task setUpBlock: self setUpBlock
]

{ #category : #creating }
TkTaskTestBench >> addSetUpTearDownBlocks [
	self addSetUpBlock.
	self addTearDownBlock.
]

{ #category : #creating }
TkTaskTestBench >> addTearDownBlock [
	task tearDownBlock: self tearDownBlock
]

{ #category : #creating }
TkTaskTestBench >> postponeStartBy100Milliseconds [
	task startAfter: 100 milliSeconds.

]

{ #category : #creating }
TkTaskTestBench >> setFrequency10Hz [
	task frequency: 10.

]

{ #category : #creating }
TkTaskTestBench >> setPeriod100Milliseconds [
	task period: 100 milliSeconds.

]

{ #category : #creating }
TkTaskTestBench >> setStartTime100MillisecondsInTheFuture [
	task startOn: DateAndTime now + 100 milliSeconds.

]

{ #category : #creating }
TkTaskTestBench >> setStartTime100MillisecondsInThePast [
	task startOn: DateAndTime now - 100 milliSeconds.

]

{ #category : #accessing }
TkTaskTestBench >> task: aTask [
	task := aTask.
	self addResetBlock.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskClass [
	^TkTask
]

{ #category : #creating }
TkTaskTestBench >> taskOneShot [
	^self task: (self taskClass doOnce: self actionBlock).

]

{ #category : #creating }
TkTaskTestBench >> taskRepeating3Times [
	^self task: (self taskClass repeat: self actionBlock times: 3).

]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingFor100Milliseconds [
	^self task: (self taskClass repeat: self actionBlock during: 100 milliSeconds).

]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingForever [
	^self task: (self taskClass repeat: self actionBlock).

]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingForeverPeriod100Milliseconds [
	self taskRepeatingForever.
	self setPeriod100Milliseconds.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingUntilFlagTrue [
	self setFlagFalse.
	^ self task: (TkTask repeat: self actionBlock until: self flagBlock)
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingUntilFlagTruePeriod100Milliseconds [
	self taskRepeatingUntilFlagTrue.
	self setPeriod100Milliseconds.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingWhileFlagTrue [
	self setFlagTrue.
	^ self task: (TkTask repeat: self actionBlock while: self flagBlock)
]
