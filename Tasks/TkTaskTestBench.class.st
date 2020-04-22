Class {
	#name : #TkTaskTestBench,
	#superclass : #Object,
	#instVars : [
		'count',
		'task',
		'flag',
		'setUpCount',
		'tearDownCount'
	],
	#category : #Tasks
}

{ #category : #creating }
TkTaskTestBench >> addSetUpTearDownBlocks [
	task setUpBlock: [ setUpCount := setUpCount + 1 ].
	task tearDownBlock: [ tearDownCount := tearDownCount + 1 ].

]

{ #category : #accessing }
TkTaskTestBench >> count [
	^ count
]

{ #category : #accessing }
TkTaskTestBench >> flag [
	^flag
]

{ #category : #initialization }
TkTaskTestBench >> initialize [
	super initialize.
	count := 0.
	setUpCount := 0.
	tearDownCount := 0.
]

{ #category : #creating }
TkTaskTestBench >> postPoneStartBy100Milliseconds [
	task startAfter: 100 milliSeconds.

]

{ #category : #accessing }
TkTaskTestBench >> setFlagFalse [
	flag := false
]

{ #category : #accessing }
TkTaskTestBench >> setFlagTrue [
	flag := true
]

{ #category : #creating }
TkTaskTestBench >> setPeriod100Milliseconds [
	task period: 100 milliSeconds.

]

{ #category : #accessing }
TkTaskTestBench >> setUpCount [
	^ setUpCount
]

{ #category : #creating }
TkTaskTestBench >> taskDoneAfter100Milliseconds [
	^task := TkTask repeat: [ count := count + 1 ] during: 100 milliSeconds.

]

{ #category : #creating }
TkTaskTestBench >> taskDoneAfter100MillisecondsWithSetupAndTearDown [
	self taskDoneAfter100Milliseconds.
	self addSetUpTearDownBlocks.
	^ task
]

{ #category : #creating }
TkTaskTestBench >> taskDoneAfter300MillisecondsPeriod100Milliseconds [
	task := TkTask repeat: [ count := count + 1 ] during: 300 milliSeconds.
	self setPeriod100Milliseconds.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskOneShot [
	^task := TkTask doOnce: [ count := count + 1 ].

]

{ #category : #creating }
TkTaskTestBench >> taskOneShotWithSetUpTearDown [
	self taskOneShot.
	self addSetUpTearDownBlocks.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeating3Times [
	^task := TkTask repeat: [ count := count + 1 ] times: 3.

]

{ #category : #creating }
TkTaskTestBench >> taskRepeating3TimesPeriod100Milliseconds [
	self taskRepeating3Times.
	self setPeriod100Milliseconds.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeating3TimesWithSetupAndTearDown [
	self taskRepeating3Times.
	self addSetUpTearDownBlocks.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingForever [
	^task := TkTask repeat: [ count := count + 1 ].

]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingForeverPeriod100Milliseconds [
	self taskRepeatingForever.
	self setPeriod100Milliseconds.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingForeverWithSetup [
	self taskRepeatingForever.
	task setUpBlock: [ setUpCount := setUpCount + 1 ].
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingUntilFlagTrue [
	self setFlagFalse.
	^task := TkTask repeat: [ count := count + 1 ] until: [flag].

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
	^task := TkTask repeat: [ count := count + 1 ] while: [flag].

]

{ #category : #accessing }
TkTaskTestBench >> tearDownCount [
	^ tearDownCount
]
