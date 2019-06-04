"
I represent a group of dice.
See class side example methods in LoDiceListPresenter

Public API and Key Messages
- roll
Roll all my dices
    
- facesUp
faces up for every one of my dice

- addDice: aDice
Add a dice to the group

- removeDice: aDice
Add a dice to the group

- how to create instances.
-- with: collectionOfDice
Creates a list with provided dice

-- withTwoDice
Creates a list with 2 dice of 6 faces each (values between 1 to 6)

-- withDiceCount: numberOfDice
Creates a list with the provided number of dice. Each dice has 6 faces with values between 1 and 6
 

"
Class {
	#name : #LoDiceList,
	#superclass : #LoSubject,
	#instVars : [
		'dice'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #'instance creation' }
LoDiceList class >> with: dice [
	^self new
		dice: dice;
		yourself
]

{ #category : #'instance creation' }
LoDiceList class >> withDiceCount: count [
	| dice |
	dice := (1 to: count) collect: [: each | LoDice new].
	^self with: dice asOrderedCollection
]

{ #category : #'instance creation' }
LoDiceList class >> withTwoDice [
	^self withDiceCount: 2
]

{ #category : #playing }
LoDiceList >> addDice [
	self addDice: LoDice new.
]

{ #category : #playing }
LoDiceList >> addDice: newDice [
	dice add: newDice.

]

{ #category : #'initialize-release' }
LoDiceList >> dice [
	^dice
]

{ #category : #'initialize-release' }
LoDiceList >> dice: aCollection [
	dice := aCollection asOrderedCollection

]

{ #category : #'initialize-release' }
LoDiceList >> diceAt: index put: diceToInsert [
	self dice at: index put: diceToInsert
]

{ #category : #accessing }
LoDiceList >> facesUp [
	^self dice collect: [ : each | each faceUp ]
]

{ #category : #'initialize-release' }
LoDiceList >> initialize [
	super initialize.
	self dice: OrderedCollection new.

]

{ #category : #playing }
LoDiceList >> removeDice [
	| diceToRemove |
	self dice ifEmpty: [ ^self ].
	diceToRemove := self dice last.
	self removeDice: diceToRemove.
]

{ #category : #playing }
LoDiceList >> removeDice: diceToRemove [
	dice remove: diceToRemove.

]

{ #category : #playing }
LoDiceList >> roll [
	dice do: [: each | each roll].

]
