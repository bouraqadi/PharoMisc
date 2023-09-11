"
I am a spec presenter for Dice.
I display the dice's face up.
I also accept clicks to make the dice roll.

For an example, see class side methods: 
- exampleBasic
- exampleFontAndColorChanged

Public API and Key Messages
-linkTo: aDice
Makes the receiver observe aDice = display its face up + act on it = make it roll upon clicks

-color: aColor
Set the background color

-font: aFont
Set the font for displaying the dice's face up


   Implementation Points
Relies on the observer pattern. I observe dice faceUp changes, and display them.

"
Class {
	#name : #LoDicePresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'diceFaceUpPresenter'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #specs }
LoDicePresenter class >> defaultSpec [

	^ SpecColumnLayout new
		add: #diceFaceUpPresenter;
		yourself
]

{ #category : #examples }
LoDicePresenter class >> example32FacesDice [
	<example>
	^self new
		linkTo: (LoDice of: 32);
		openWithSpec;
		yourself

]

{ #category : #examples }
LoDicePresenter class >> exampleAlphabetDice [
	<example>
	^self new
		linkTo: (LoDice faces: Character alphabet asUppercase);
		openWithSpec;
		yourself

]

{ #category : #examples }
LoDicePresenter class >> exampleBasic [
	<example>
	^self new
		linkTo: LoDice new;
		openWithSpec;
		yourself

]

{ #category : #examples }
LoDicePresenter class >> exampleFontAndColorChanged [
	<example>
	^self new
		linkTo: LoDice new;
		color: Color paleBlue;
		font: (LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 94);
		openWithSpec;
		yourself

]

{ #category : #specs }
LoDicePresenter class >> title [
	
	^ 'Dice (Click to Roll)'
]

{ #category : #initialization }
LoDicePresenter >> color: aColor [
	diceFaceUpPresenter color: aColor
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
LoDicePresenter >> diceFaceUp: newValue [
	diceFaceUpPresenter label: newValue asString.

]

{ #category : #accessing }
LoDicePresenter >> diceFaceUpPresenter [
	^diceFaceUpPresenter
]

{ #category : #initialization }
LoDicePresenter >> diceFaceUpString [
	^diceFaceUpPresenter label asString
]

{ #category : #initialization }
LoDicePresenter >> font: font [
	diceFaceUpPresenter font: font
]

{ #category : #initialization }
LoDicePresenter >> initialExtent [
	^300@200
]

{ #category : #initialization }
LoDicePresenter >> initializeWidgets [
	diceFaceUpPresenter := self newButton.
	self diceFaceUp: '-'.
	self font: self defaultFont.
	self color: self defaultColor.
	
]

{ #category : #initialization }
LoDicePresenter >> linkTo: aDice [
	self diceFaceUp: aDice faceUp.
	aDice afterChangeOf: #faceUp do: [ : newValue |  self diceFaceUp: newValue].
	diceFaceUpPresenter action: [ aDice roll ]. 

]
