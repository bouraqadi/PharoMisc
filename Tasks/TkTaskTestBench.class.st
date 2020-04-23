Class {
	#name : #TkTaskTestBench,
	#superclass : #Object,
	#instVars : [
		'task',
		'setUpCount',
		'tearDownCount',
		'resetCount',
		'flag',
		'actionCount'
	],
	#category : #Tasks
}

{ #category : #accessing }
TkTaskTestBench >> actionBlock [
	^ [ actionCount := actionCount + 1 ]
]

{ #category : #accessing }
TkTaskTestBench >> actionCount [
	^ actionCount
]

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

{ #category : #initialization }
TkTaskTestBench >> initialize [
	super initialize.
	actionCount := 0.
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
TkTaskTestBench >> taskRepeatingForever [
	^self task: (self taskClass repeat: self actionBlock).

]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingUntilFlagTrue [
	self setFlagFalse.
	^self task: (TkTask repeat: self actionBlock until: [flag]).

]

{ #category : #creating }
TkTaskTestBench >> taskRepeatingWhileFlagTrue [
	self setFlagTrue.
	^ self task: (TkTask repeat: self actionBlock while: [ flag ])
]

{ #category : #accessing }
TkTaskTestBench >> tearDownCount [
	^ tearDownCount
]
