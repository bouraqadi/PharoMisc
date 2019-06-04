"
I am a list of numerical dice. I computes the total of faces up, upon rolling dice, or when adding or removing dice.

Public API and Key Messages
- total
Answers the current total of dice faces up

   Implementation Points
Relies on the observer pattern to update total upon a dice collection change, a dice faceUp change
See methods linkTo: and addDice:

"
Class {
	#name : #LoDiceAdder,
	#superclass : #LoDiceList,
	#instVars : [
		'total'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #'initialize-release' }
LoDiceAdder >> dice: aCollection [
	super dice: aCollection.
	self dice do: [ : each | self linkTo: each].

]

{ #category : #'initialize-release' }
LoDiceAdder >> initialize [
	super initialize.
	self afterChangeOfCollection: #dice do: [ self updateTotal ].
	self afterReplaceInCollection: #dice do: [: index : newDice | 
		self linkTo: newDice ].
	self afterAddToCollection: #dice do: [: newDice | 
		self linkTo: newDice ].
	self afterChangeOf: #dice do: [ self updateTotal ].
	self updateTotal
]

{ #category : #playing }
LoDiceAdder >> linkTo: aDice [
	aDice afterChangeOf: #faceUp do: [ self updateTotal ]. 
]

{ #category : #playing }
LoDiceAdder >> total [
	^total
]

{ #category : #'private-generated' }
LoDiceAdder >> total: anObject [
	total := anObject
]

{ #category : #playing }
LoDiceAdder >> updateTotal [
	| newTotal |
	newTotal := self dice inject: 0 into: [ : sum : each | sum + each faceUp].
	^self total: newTotal
]
