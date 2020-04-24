Class {
	#name : #TkTask,
	#superclass : #Object,
	#instVars : [
		'actionBlock',
		'automaton',
		'pendingState',
		'actionState',
		'setUpBlock',
		'setUpState',
		'resetBlock',
		'tearDownBlock',
		'period',
		'dueTime'
	],
	#category : #'Tasks-Kernel'
}

{ #category : #'instance creation' }
TkTask class >> doOnce: aBlockClosure [ 
	^self repeat: aBlockClosure times: 1.
]

{ #category : #'instance creation' }
TkTask class >> repeat: aBlockClosure [ 
	^self new
		actionBlock: aBlockClosure;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: aBlockClosure during: aDuration [ 
	^(TkFiniteDurationTask repeat: aBlockClosure)
		duration: aDuration;
		yourself 
]

{ #category : #'instance creation' }
TkTask class >> repeat: aBlockClosure times: times [
	^(TkFiniteIterationsTask repeat: aBlockClosure) 
		totalIterations: times;
		yourself 
]

{ #category : #'instance creation' }
TkTask class >> repeat: stepBlock until: endConditionBlock [
	^(TkGenericFiniteTask repeat: stepBlock)
		endConditionBlock: endConditionBlock;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: stepBlock while: continueConditionBlock [
	^self repeat: stepBlock until: [continueConditionBlock value not]
]

{ #category : #acting }
TkTask >> act [
	self state act
]

{ #category : #accessing }
TkTask >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
TkTask >> actionBlock: anObject [
	actionBlock := anObject
]

{ #category : #accessing }
TkTask >> dueTime [
	^ dueTime
]

{ #category : #accessing }
TkTask >> dueTime: anObject [
	dueTime := anObject
]

{ #category : #accessing }
TkTask >> frequency [
	^1000 / self period asMilliSeconds
]

{ #category : #accessing }
TkTask >> frequency: newFrequency [
	self period: (1000/newFrequency) milliSeconds
]

{ #category : #initialization }
TkTask >> initialize [
	super initialize.
	automaton := SmAutomaton new.
	pendingState := self newState: TkPendingTaskState.
	pendingState 
	automaton initialState: pendingState.
	actionState := self newState: TkActingTaskState.
	setUpState := self newState: TkSetUpTaskState.
	pendingState transitionTo: actionState when: [self setUpBlock isNil].
	pendingState transitionTo: setUpState when: [ self setUpBlock notNil ].
	setUpState transitionTo: actionState.

]

{ #category : #testing }
TkTask >> isDone [
	^self state isDone
]

{ #category : #testing }
TkTask >> isDue [
	^self state isDue
]

{ #category : #initialization }
TkTask >> newState: stateClass [
	| newState |
	newState := automaton newState: stateClass.
	newState task: self.
	^newState
]

{ #category : #accessing }
TkTask >> now [
	^DateAndTime now
]

{ #category : #accessing }
TkTask >> period [
	^ period
]

{ #category : #accessing }
TkTask >> period: anObject [
	period := anObject
]

{ #category : #acting }
TkTask >> reset [
	self resetBlock value.
	automaton currentState: pendingState.
	self dueTime: nil.
]

{ #category : #accessing }
TkTask >> resetBlock [
	^ resetBlock
]

{ #category : #accessing }
TkTask >> resetBlock: anObject [
	resetBlock := anObject
]

{ #category : #accessing }
TkTask >> setUpBlock [
	^ setUpBlock
]

{ #category : #accessing }
TkTask >> setUpBlock: aBlockClosure [ 
	setUpBlock := aBlockClosure
]

{ #category : #acting }
TkTask >> startAfter: aDuration [
	self state startAfter: aDuration
]

{ #category : #acting }
TkTask >> startOn: dateAndTime [
	self startAfter: dateAndTime - self now
]

{ #category : #accessing }
TkTask >> state [
	^ automaton currentState
]

{ #category : #acting }
TkTask >> step [
	automaton step.
	self act.

]

{ #category : #accessing }
TkTask >> tearDownBlock [
	^ tearDownBlock
]

{ #category : #accessing }
TkTask >> tearDownBlock: aBlockClosure [ 
	tearDownBlock := aBlockClosure
]

{ #category : #acting }
TkTask >> updateDueTime [
	self period ifNil: [ ^self ].
	self dueTime: self now + self period
]

{ #category : #acting }
TkTask >> valueActionBlock [
	self actionBlock value.
	self updateDueTime.
]

{ #category : #acting }
TkTask >> valueSetUpBlock [
	self setUpBlock value
]

{ #category : #acting }
TkTask >> valueTearDownBlock [
	self tearDownBlock value
]
