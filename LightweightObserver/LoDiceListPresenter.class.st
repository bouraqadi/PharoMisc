"
I am a spec presenter for a DiceList.
I display the faces up for all Dice.
I also accept clicks to make individual dice roll.
I am dynamic, so I adapt upon the addition or removal of dice to/from the dice list

I rely on LoDice and LoDicePresenter

For an example, see class side methods: 
- exampleProvidedDice
Answers diceList that can be inspected and changed to see consequences
- exampleBasicDice
Answers diceList that can be inspected and changed to see consequences

Public API and Key Messages
-linkTo: aDiceList
Makes the receiver observe diceList and act on it = when a dice is changed, its face up is displayed, when a dice is added or removed, the display is adapted accordingly + roll individual dice upon clicks

   Implementation Points
Relies on the observer pattern.
Uses LoDicePresenter to display and interact with individual dice

"
Class {
	#name : #LoDiceListPresenter,
	#superclass : #DynamicComposablePresenter,
	#instVars : [
		'dicePresenters'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #specs }
LoDiceListPresenter class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :column |  ];
		yourself
]

{ #category : #example }
LoDiceListPresenter class >> exampleBasicDice [
	<example>
	| presenter diceList |
	presenter := self new.
	diceList := LoDiceList withDiceCount: 3.
	presenter linkTo: diceList.
	presenter openWithSpec.
	^ diceList
]

{ #category : #example }
LoDiceListPresenter class >> exampleProvidedDice [
	<example>
	| presenter diceList |
	diceList := LoDiceList with:{ 
		LoDice faces: Character alphabet asUppercase.
		LoDice of: 32
	 }.
	presenter := self new.
	presenter linkTo: diceList.
	presenter openWithSpec.
	^ diceList
]

{ #category : #protocol }
LoDiceListPresenter >> addPresenterForDice: aDice [ 
	| dicePresenter |
	dicePresenter := LoDicePresenter new.
	dicePresenter linkTo: aDice.
	dicePresenters add: dicePresenter.
	dicePresenter owner: self.
	self rebuildWidget
]

{ #category : #accessing }
LoDiceListPresenter >> createWidgets [
	dicePresenters withIndexDo: [ :each :i | 
			self assign: each to: ('diceDisplay' , i asString) asSymbol.
			 ]
]

{ #category : #protocol }
LoDiceListPresenter >> default: aButton [
	aButton privateSetState: true.
	aButton takeKeyboardFocus.
	aButton
		whenBuiltDo: [ aButton privateSetState: true.
			self currentActivated: aButton]
	
]

{ #category : #accessing }
LoDiceListPresenter >> dicePresenters [
	^ dicePresenters
]

{ #category : #specs }
LoDiceListPresenter >> dynamicLayout [
	|lay|
	lay := SpecLayout composed newRow: [ : mainRow | 
		widgets keysDo: [ :item | mainRow add: item ]
	].
	self layout: lay.
	^ lay
]

{ #category : #initialization }
LoDiceListPresenter >> initialize [
	dicePresenters := OrderedCollection new.
	super initialize.
]

{ #category : #initialization }
LoDiceListPresenter >> initializePresenter [
	^super initializePresenter
]

{ #category : #initialization }
LoDiceListPresenter >> linkTo: aDiceList [
	aDiceList dice do: [ : aDice | self addPresenterForDice: aDice].
	aDiceList 
		afterAddToCollection: #dice 
		do: [ : newDice | self addPresenterForDice: newDice ].
	aDiceList 
		afterRemoveFromCollection: #dice 
		do: [ : oldDice : oldDiceIndex | self removePresenterAt: oldDiceIndex ].

]

{ #category : #accessing }
LoDiceListPresenter >> rebuildWidget [
	self widgets removeAll.
	self createWidgets.
	self needFullRebuild: false.
	self buildWithSpecLayout: self dynamicLayout
]

{ #category : #protocol }
LoDiceListPresenter >> removePresenterAt: index [ 
	dicePresenters removeAt: index.
	self rebuildWidget
]

{ #category : #api }
LoDiceListPresenter >> title [
	^'Dice Group'
]
