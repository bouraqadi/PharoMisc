"
I am a spect presenter for DiceAdder.
I display the faces up for all Dice.
I display the total of all faces  up.
I allow rolling all dice or make individual dice roll.
I allow adding/removing dice dynamically.

For an example, see class side methods: 
- example

I rely on LoDice, LoDicePresenter and LoDiceListPresenter

-linkTo: aDiceAdder
Makes the receiver observe aDiceAdder and act on it = when a dice is changed, its face up is displayed, when a dice is added or removed, the display is adapted accordingly + roll dice upon clicks

   Implementation Points
Relies on the observer pattern.

"
Class {
	#name : #LoDiceAdderPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'totalPresenter',
		'rollButton',
		'addDiceButton',
		'removeDiceButton',
		'diceGroupPresenter'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #specs }
LoDiceAdderPresenter class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ : rootColumn |  
			rootColumn add: #diceListPresenter height: 100.
			rootColumn 
				newRow: [ : diceButtonsRow |
					diceButtonsRow add: #addDiceButton.
					diceButtonsRow add: #removeDiceButton]
				height: 60.
			rootColumn add: #totalPresenter height: 100.
			rootColumn add: #rollButton
			];
		yourself
]

{ #category : #examples }
LoDiceAdderPresenter class >> example [
	<example>
	| presenter diceGroup |
	presenter := self new.
	diceGroup := LoDiceAdder withDiceCount: 3.
	presenter linkTo: diceGroup.
	presenter openWithSpec.
	^ presenter
]

{ #category : #accessing }
LoDiceAdderPresenter >> addDiceButton [
	^ addDiceButton
]

{ #category : #accessing }
LoDiceAdderPresenter >> diceListPresenter [
	^ diceGroupPresenter
]

{ #category : #accessing }
LoDiceAdderPresenter >> dicePresenters [
	^ self diceListPresenter dicePresenters
]

{ #category : #api }
LoDiceAdderPresenter >> initialExtent [
	^360@440
]

{ #category : #initialization }
LoDiceAdderPresenter >> initializeWidgets [
	totalPresenter := self newButton.
	totalPresenter font: self majorFont.
	totalPresenter color: Color green.
	addDiceButton := self newButton.
	addDiceButton label: '+'.
	addDiceButton font: self minorFont.
	removeDiceButton := self newButton.
	removeDiceButton label: '-'.
	removeDiceButton font: self minorFont.
	rollButton  := self newButton.
	rollButton label: 'Roll Dice'.
	rollButton font: self minorFont.
	diceGroupPresenter := LoDiceListPresenter new.
]

{ #category : #initialization }
LoDiceAdderPresenter >> linkTo: aDiceGroup [
	diceGroupPresenter linkTo: aDiceGroup.
	addDiceButton action: [ aDiceGroup addDice ].
	removeDiceButton action: [ aDiceGroup removeDice ].
	rollButton action: [ aDiceGroup roll ].
	aDiceGroup
		afterChangeOf: #total
		do: [ :newTotal | self totalValue: newTotal ].
	self totalValue: aDiceGroup total
]

{ #category : #initialization }
LoDiceAdderPresenter >> majorFont [
	^LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 42. 
]

{ #category : #initialization }
LoDiceAdderPresenter >> minorFont [
	^LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 24. 
]

{ #category : #accessing }
LoDiceAdderPresenter >> removeDiceButton [
	^ removeDiceButton
]

{ #category : #accessing }
LoDiceAdderPresenter >> rollButton [
	^ rollButton
]

{ #category : #api }
LoDiceAdderPresenter >> title [
	^'Dice Game'
]

{ #category : #accessing }
LoDiceAdderPresenter >> totalPresenter [
	^ totalPresenter
]

{ #category : #accessing }
LoDiceAdderPresenter >> totalString [
	^self totalPresenter label asString
]

{ #category : #initialization }
LoDiceAdderPresenter >> totalValue: newTotal [
	^ totalPresenter label: newTotal asString
]
