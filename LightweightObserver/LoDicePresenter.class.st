Class {
	#name : #LoDicePresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'diceValueDisplay'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #specs }
LoDicePresenter class >> defaultSpec [

	^ SpecColumnLayout new
		add: #diceValueDisplay;
		yourself
]

{ #category : #examples }
LoDicePresenter class >> example [
	<example>
	^self new
		linkTo: LoDice new;
		openWithSpec;
		yourself

]

{ #category : #specs }
LoDicePresenter class >> title [
	
	^ 'Dice'
]

{ #category : #initialization }
LoDicePresenter >> color: aColor [
	diceValueDisplay color: aColor
]

{ #category : #queries }
LoDicePresenter >> defaultColor [
	^Color yellow
]

{ #category : #queries }
LoDicePresenter >> defaultFont [
	^LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 42
]

{ #category : #initialization }
LoDicePresenter >> diceValue [
	^diceValueDisplay label
]

{ #category : #initialization }
LoDicePresenter >> diceValue: newValue [
	diceValueDisplay label: newValue asString.

]

{ #category : #accessing }
LoDicePresenter >> diceValueDisplay [
	^diceValueDisplay
]

{ #category : #initialization }
LoDicePresenter >> font: font [
	diceValueDisplay font: font
]

{ #category : #initialization }
LoDicePresenter >> initialExtent [
	^200@200
]

{ #category : #initialization }
LoDicePresenter >> initializeWidgets [
	diceValueDisplay := self newButton.
	self diceValue: '-'.
	self font: self defaultFont.
	self color: self defaultColor.
	
]

{ #category : #initialization }
LoDicePresenter >> linkTo: aDice [
	self diceValue: aDice faceUp.
	aDice afterChangeOf: #faceUp do: [ : newValue |  self diceValue: newValue].
	diceValueDisplay action: [ aDice roll ]. 

]
