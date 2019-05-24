Class {
	#name : #LoDiceDisplay,
	#superclass : #ComposablePresenter,
	#instVars : [
		'diceValueDisplay'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #specs }
LoDiceDisplay class >> defaultSpec [

	^ SpecColumnLayout new
		add: #diceValueDisplay;
		yourself
]

{ #category : #specs }
LoDiceDisplay class >> title [
	
	^ 'Dice'
]

{ #category : #initialization }
LoDiceDisplay >> borderColor: aColor [
	diceValueDisplay borderColor: aColor
]

{ #category : #initialization }
LoDiceDisplay >> borderWidth: anInteger [
	diceValueDisplay borderWidth: anInteger
]

{ #category : #initialization }
LoDiceDisplay >> color: aColor [
	diceValueDisplay color: aColor
]

{ #category : #initialization }
LoDiceDisplay >> diceValue [
	^diceValueDisplay label
]

{ #category : #initialization }
LoDiceDisplay >> diceValue: newValue [
	diceValueDisplay label: newValue asString.

]

{ #category : #initialization }
LoDiceDisplay >> font: font [
	diceValueDisplay font: font
]

{ #category : #initialization }
LoDiceDisplay >> initializeWidgets [
	diceValueDisplay := self newButton.
	self diceValue: '-'
]

{ #category : #initialization }
LoDiceDisplay >> observe: aDice [
	aDice afterChangeOf: #faceUp do: [ : newValue |  self diceValue: newValue] 
]
