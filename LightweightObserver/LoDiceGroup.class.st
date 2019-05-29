Class {
	#name : #LoDiceGroup,
	#superclass : #LoSubject,
	#instVars : [
		'dice',
		'total'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #'instance creation' }
LoDiceGroup class >> with: dice [
	^self new
		dice: dice;
		yourself
]

{ #category : #'instance creation' }
LoDiceGroup class >> withDiceCount: count [
	| dice |
	dice := (1 to: count) collect: [: each | LoDice basic].
	^self with: dice asOrderedCollection
]

{ #category : #'instance creation' }
LoDiceGroup class >> withTwoDice [
	^self withDiceCount: 2
]

{ #category : #playing }
LoDiceGroup >> addDice [
	self addDice: LoDice new.
]

{ #category : #playing }
LoDiceGroup >> addDice: newDice [
	dice add: newDice.
	self linkTo: newDice.
	self updateTotal
]

{ #category : #'initialize-release' }
LoDiceGroup >> dice [
	^dice
]

{ #category : #'initialize-release' }
LoDiceGroup >> dice: aCollection [
	dice := aCollection.
	dice do: [ : each | self linkTo: each].
	self updateTotal
]

{ #category : #'initialize-release' }
LoDiceGroup >> initialize [
	super initialize.
	self dice: OrderedCollection new.

]

{ #category : #playing }
LoDiceGroup >> linkTo: aDice [
	aDice afterChangeOf: #faceUp do: [ self updateTotal ]. 
]

{ #category : #playing }
LoDiceGroup >> removeDice [
	| diceToRemove |
	self dice ifEmpty: [ ^self ].
	diceToRemove := self dice last.
	self removeDice: diceToRemove.
]

{ #category : #playing }
LoDiceGroup >> removeDice: diceToRemove [
	dice remove: diceToRemove.
	self updateTotal
]

{ #category : #playing }
LoDiceGroup >> roll [
	dice do: [: each | each roll].
	^self updateTotal
]

{ #category : #playing }
LoDiceGroup >> total [
	^total
]

{ #category : #'private-generated' }
LoDiceGroup >> total: anObject [
	total := anObject
]

{ #category : #playing }
LoDiceGroup >> updateTotal [
	| newTotal |
	newTotal := dice inject: 0 into: [ : sum : each | sum + each faceUp].
	^self total: newTotal
]
