Class {
	#name : #LoDiceSetDisplay,
	#superclass : #ComposablePresenter,
	#instVars : [
		'diceDisplays',
		'diceRow',
		'totalDisplay',
		'rollButton'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #specs }
LoDiceSetDisplay class >> defaultSpec [

	^ SpecColumnLayout new
		newRow: #diceRow height: 100;
		add: #totalDisplay;
		add: #rollButton;
		yourself
]

{ #category : #specs }
LoDiceSetDisplay class >> title [
	
	^ 'Dice'
]

{ #category : #initialization }
LoDiceSetDisplay >> addDisplayForDice: newDice [ 
	
]

{ #category : #initialization }
LoDiceSetDisplay >> diceCount: diceCount [
	| builder |
	builder := DynamicPresentersListBuilder new.
	^builder 
		modelObjects: (1 to: diceCount);
		layoutBuilder: (DynamicTopToBottomColumnsLayout columns: diceCount);
		build
]

{ #category : #accessing }
LoDiceSetDisplay >> diceDisplays [
	^diceDisplays
]

{ #category : #accessing }
LoDiceSetDisplay >> diceRow [
	^ diceRow
]

{ #category : #initialization }
LoDiceSetDisplay >> initialize [
	super initialize.
	diceDisplays := #()
]

{ #category : #initialization }
LoDiceSetDisplay >> initializeWidgets [
	totalDisplay := self newText.
	totalDisplay text: '-'.
	rollButton  := self newButton label: 'Roll Dice'.
]

{ #category : #initialization }
LoDiceSetDisplay >> observe: aDiceSet [
	aDiceSet afterChangeOf: #total do: [ : newTotal |  self totalValue: newTotal].
	aDiceSet 
		afterAddToCollection: #dice 
		do: [ : newDice | self addDisplayForDice: newDice ]
]

{ #category : #accessing }
LoDiceSetDisplay >> rollButton [
	^ rollButton
]

{ #category : #accessing }
LoDiceSetDisplay >> totalValue [
	^nil
]

{ #category : #accessing }
LoDiceSetDisplay >> totalValue: newTotal [
	
]
