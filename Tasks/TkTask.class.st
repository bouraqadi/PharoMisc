Class {
	#name : #TkTask,
	#superclass : #Object,
	#instVars : [
		'stepBlock',
		'setUpBlock',
		'isSetUpDone',
		'period',
		'dueTime'
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
		stepBlock: aBlockClosure;
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
	^(TkFiniteTask repeat: stepBlock)
		endConditionBlock: endConditionBlock;
		yourself
]

{ #category : #'instance creation' }
TkTask class >> repeat: stepBlock while: continueConditionBlock [
	^self repeat: stepBlock until: [continueConditionBlock value not]
]

{ #category : #acting }
TkTask >> afterStep [
	self period ifNil: [ ^self ].
	self dueTime: self now + self period
]

{ #category : #acting }
TkTask >> beforeStep [
	self isSetUpDone
		ifTrue: [ ^ self ].
	self setUp.
	self isSetUpDone: true
]

{ #category : #accessing }
TkTask >> dueTime [
	^dueTime
]

{ #category : #accessing }
TkTask >> dueTime: aDateAndTime [
	dueTime := aDateAndTime
]

{ #category : #initialization }
TkTask >> initialize [
	super initialize.
	self reset
]

{ #category : #testing }
TkTask >> isDone [
	^false
]

{ #category : #testing }
TkTask >> isDue [
	self dueTime ifNil: [ ^true ].
	^self dueTime <= self now
]

{ #category : #testing }
TkTask >> isSetUpDone [
	^ isSetUpDone
]

{ #category : #accessing }
TkTask >> isSetUpDone: anObject [
	isSetUpDone := anObject
]

{ #category : #accessing }
TkTask >> now [
	^DateAndTime now
]

{ #category : #accessing }
TkTask >> period [
	^period
]

{ #category : #accessing }
TkTask >> period: aDuration [ 
	period := aDuration
]

{ #category : #initialization }
TkTask >> reset [
	self isSetUpDone: false.
	self dueTime: nil.
]

{ #category : #acting }
TkTask >> setUp [
	self setUpBlock value
]

{ #category : #accessing }
TkTask >> setUpBlock [
	^ setUpBlock
]

{ #category : #accessing }
TkTask >> setUpBlock: aBlockClosure [ 
	setUpBlock := aBlockClosure
]

{ #category : #initialization }
TkTask >> startAfter: aDuration [
	self dueTime: self now + aDuration
]

{ #category : #acting }
TkTask >> step [
	self beforeStep.
	self stepBlock value.
	self afterStep.
]

{ #category : #accessing }
TkTask >> stepBlock [
	^ stepBlock
]

{ #category : #accessing }
TkTask >> stepBlock: anObject [
	stepBlock := anObject
]
