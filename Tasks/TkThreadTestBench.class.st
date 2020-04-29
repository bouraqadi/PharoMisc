Class {
	#name : #TkThreadTestBench,
	#superclass : #TkTestBench,
	#instVars : [
		'thread'
	],
	#category : #'Tasks-Tests'
}

{ #category : #initialization }
TkThreadTestBench >> addResetBlock [
	thread resetBlock: self resetBlock
]

{ #category : #initialization }
TkThreadTestBench >> addSetUpTearDownBlocks [
	thread setUpBlock: self setUpBlock.
	thread tearDownBlock: self tearDownBlock
]

{ #category : #creating }
TkThreadTestBench >> thread: aThread [
	thread := aThread.
	thread name: 'Thread for Test'.
	self addResetBlock.
	^thread
]

{ #category : #creating }
TkThreadTestBench >> threadClass [
	^TkThread
]

{ #category : #creating }
TkThreadTestBench >> threadDoOnce [
	^self thread: (self threadClass doOnce: self actionBlock).

]

{ #category : #creating }
TkThreadTestBench >> threadRepeating3Times [
	^self thread: (self threadClass repeat: self actionBlock times: 3).

]

{ #category : #creating }
TkThreadTestBench >> threadRepeating3TimesPeriod100Milliseconds [
	^self thread: (self threadClass repeat: self actionBlock times: 3 every: 100 milliSeconds).

]

{ #category : #creating }
TkThreadTestBench >> threadRepeatingFor100Milliseconds [
	^self thread: (self threadClass repeat: self actionBlock during: 300 milliSeconds).

]

{ #category : #creating }
TkThreadTestBench >> threadRepeatingFor300MillisecondPeriod100Milliseconds [
	^self thread: (self threadClass repeat: self actionBlock during: 300 milliSeconds every: 100milliSeconds).

]

{ #category : #creating }
TkThreadTestBench >> threadRepeatingForever [
	^self thread: (self threadClass repeat: self actionBlock).

]

{ #category : #creating }
TkThreadTestBench >> threadRepeatingForeverPeriod100Milliseconds [
	^self thread: (self threadClass repeat: self actionBlock every: 100 milliSeconds).

]

{ #category : #creating }
TkThreadTestBench >> threadUntilFlagTruePeriod100Milliseconds [
	self setFlagFalse.
	^self thread: (self threadClass repeat: self actionBlock until: self flagBlock every: 100 milliSeconds ).

]

{ #category : #creating }
TkThreadTestBench >> threadWhileFlagTruePeriod100Milliseconds [
	self setFlagTrue.
	^self thread: (self threadClass repeat: self actionBlock while: self flagBlock every: 100 milliSeconds ).

]
