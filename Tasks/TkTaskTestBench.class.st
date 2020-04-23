Class {
	#name : #TkTaskTestBench,
	#superclass : #Object,
	#instVars : [
		'task',
		'count',
		'setUpCount',
		'tearDownCount',
		'resetCount',
		'flag'
	],
	#category : #Tasks
}

{ #category : #creating }
TkTaskTestBench >> addResetBlock [
	task resetBlock: [ resetCount := resetCount + 1 ]
]

{ #category : #creating }
TkTaskTestBench >> addSetUpBlock [
	task setUpBlock: [ setUpCount := setUpCount + 1 ]
]

{ #category : #creating }
TkTaskTestBench >> addTearDownBlock [
	task tearDownBlock: [ tearDownCount := tearDownCount + 1 ].

]

{ #category : #accessing }
TkTaskTestBench >> count [
	^ count
]

{ #category : #initialization }
TkTaskTestBench >> initialize [
	super initialize.
	count := 0.
	setUpCount := 0.
	tearDownCount := 0.
	resetCount := 0
]

{ #category : #accessing }
TkTaskTestBench >> resetCount [
	^ resetCount
]

{ #category : #accessing }
TkTaskTestBench >> setFlagFalse [
	flag := false
]

{ #category : #accessing }
TkTaskTestBench >> setFlagTrue [
	flag := true
]

{ #category : #accessing }
TkTaskTestBench >> setUpCount [
	^ setUpCount
]

{ #category : #accessing }
TkTaskTestBench >> task [
	^ task
]

{ #category : #creating }
TkTaskTestBench >> taskClass [
	^TkTask
]

{ #category : #creating }
TkTaskTestBench >> taskOneShot [
	task := self taskClass doOnce: [ count := count + 1 ].
	self addResetBlock.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingForever [
	task := self taskClass repeat: [ count := count + 1 ].
	self addResetBlock.
	^task
]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingUntilFlagTrue [
	self setFlagFalse.
	task := TkTask repeat: [ count := count + 1 ] until: [flag].
	self addResetBlock.
	^task
]

{ #category : #accessing }
TkTaskTestBench >> tearDownCount [
	^ tearDownCount
]
