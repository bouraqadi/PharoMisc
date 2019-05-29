Class {
	#name : #LoDiceGamePresenter,
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
LoDiceGamePresenter class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ : rootColumn |  
			rootColumn add: #diceGroupPresenter height: 100.
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
LoDiceGamePresenter class >> example [
	<example>
	| presenter diceGroup |
	presenter := self new.
	diceGroup := LoDiceGroup withDiceCount: 3.
	presenter linkTo: diceGroup.
	presenter openWithSpec.
	^ presenter
]

{ #category : #accessing }
LoDiceGamePresenter >> addDiceButton [
	^ addDiceButton
]

{ #category : #accessing }
LoDiceGamePresenter >> diceGroupPresenter [
	^ diceGroupPresenter
]

{ #category : #accessing }
LoDiceGamePresenter >> dicePresenters [
	^ self diceGroupPresenter dicePresenters
]

{ #category : #api }
LoDiceGamePresenter >> initialExtent [
	^360@440
]

{ #category : #initialization }
LoDiceGamePresenter >> initializeWidgets [
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
	diceGroupPresenter := LoDiceGroupPresenter new.
]

{ #category : #initialization }
LoDiceGamePresenter >> linkTo: aDiceGroup [
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
LoDiceGamePresenter >> majorFont [
	^LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 42. 
]

{ #category : #initialization }
LoDiceGamePresenter >> minorFont [
	^LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 24. 
]

{ #category : #accessing }
LoDiceGamePresenter >> removeDiceButton [
	^ removeDiceButton
]

{ #category : #accessing }
LoDiceGamePresenter >> rollButton [
	^ rollButton
]

{ #category : #api }
LoDiceGamePresenter >> title [
	^'Dice Game'
]

{ #category : #accessing }
LoDiceGamePresenter >> totalPresenter [
	^ totalPresenter
]

{ #category : #accessing }
LoDiceGamePresenter >> totalValue [
	^self totalPresenter text
]

{ #category : #initialization }
LoDiceGamePresenter >> totalValue: newTotal [
	^ totalPresenter label: newTotal asString
]
