Class {
	#name : #TkTestBench,
	#superclass : #Object,
	#instVars : [
		'setUpCount',
		'tearDownCount',
		'resetCount',
		'flag',
		'actionCount'
	],
	#category : #'Tasks-Tests'
}

{ #category : #accessing }
TkTestBench >> actionBlock [
	^ [ actionCount := actionCount + 1 ]
]

{ #category : #accessing }
TkTestBench >> actionCount [
	^ actionCount
]

{ #category : #creating }
TkTestBench >> flagBlock [
	^ [ flag ]
]

{ #category : #initialization }
TkTestBench >> initialize [
	super initialize.
	actionCount := 0.
	setUpCount := 0.
	tearDownCount := 0.
	resetCount := 0
]

{ #category : #creating }
TkTestBench >> resetBlock [
	^ [ resetCount := resetCount + 1 ]
]

{ #category : #accessing }
TkTestBench >> resetCount [
	^ resetCount
]

{ #category : #accessing }
TkTestBench >> setFlagFalse [
	flag := false
]

{ #category : #accessing }
TkTestBench >> setFlagTrue [
	flag := true
]

{ #category : #creating }
TkTestBench >> setUpBlock [
	^ [ setUpCount := setUpCount + 1 ]
]

{ #category : #accessing }
TkTestBench >> setUpCount [
	^ setUpCount
]

{ #category : #creating }
TkTestBench >> tearDownBlock [
	^ [ tearDownCount := tearDownCount + 1 ]
]

{ #category : #accessing }
TkTestBench >> tearDownCount [
	^ tearDownCount
]

{ #category : #creating }
TkTestBench >> time100MillisecondsInTheFuture [
	^ DateAndTime now + 100 milliSeconds
]

{ #category : #creating }
TkTestBench >> time100MillisecondsInThePast [
	^ DateAndTime now - 100 milliSeconds
]
