"
A task is a set of statements that can be performed in a controlled manner. This can be at a specific point in time. It can be performed repeatedly at a given frequency. It can be repeated forever. Conversely, it can be repeated for a given amount of iterations, or until some condition or some point in time is reached.
"
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
		'period',
		'dueTime'
	],
	#category : #'Tasks-Public'
}

{ #category : #'instance creation' }
TkTask class >> doOnce: actionBlock [ 
	^self repeat: actionBlock times: 1.
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock [ 
	^self new
		actionBlock: actionBlock;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock during: aDuration [ 
	^(TkFiniteDurationTask repeat: actionBlock)
		duration: aDuration;
		yourself 
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock during: aDuration every: durationPeriod [
	^(self repeat: actionBlock during: aDuration)
		period: durationPeriod;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock every: durationPeriod [
	^(self repeat: actionBlock)
		period: durationPeriod;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock times: times [
	^(TkFiniteIterationsTask repeat: actionBlock) 
		totalIterations: times;
		yourself 
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock times: times every: durationPeriod [
	^(self repeat: actionBlock times: times)
		period: durationPeriod;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock until: endConditionBlock [
	^(TkGenericFiniteTask repeat: actionBlock)
		endConditionBlock: endConditionBlock;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock until: endConditionBlock every: durationPeriod [
	^(self repeat: actionBlock until: endConditionBlock)
		period: durationPeriod;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock while: continueConditionBlock [
	^self repeat: actionBlock until: [continueConditionBlock value not]
]

{ #category : #'instance creation' }
TkTask class >> repeat: actionBlock while: continueConditionBlock every: durationPeriod [
	^(self repeat: actionBlock while: continueConditionBlock)
		period: durationPeriod;
		yourself
]

{ #category : #acting }
TkTask >> act [
	self state act
]

{ #category : #acting }
TkTask >> actAfter: aDuration [
	self state actAfter: aDuration
]

{ #category : #acting }
TkTask >> actOn: dateAndTime [
	self actAfter: dateAndTime - self now
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
TkTask >> durationToDueTime [
	^self dueTime - self now
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

{ #category : #accessing }
TkTask >> state [
	^ automaton currentState
]

{ #category : #acting }
TkTask >> step [
	automaton step.
	self act.

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
