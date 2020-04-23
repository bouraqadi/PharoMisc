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
		'tearDownBlock'
	],
	#category : #Tasks
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

{ #category : #acting }
TkTask >> reset [
	self resetBlock value.
	automaton currentState: pendingState
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

{ #category : #accessing }
TkTask >> state [
	^ automaton currentState
]

{ #category : #acting }
TkTask >> step [
	automaton step.
	self act
]

{ #category : #accessing }
TkTask >> tearDownBlock [
	^ tearDownBlock
]

{ #category : #accessing }
TkTask >> tearDownBlock: aBlockClosure [ 
	tearDownBlock := aBlockClosure
]
