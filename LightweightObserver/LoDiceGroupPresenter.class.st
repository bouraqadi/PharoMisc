Class {
	#name : #LoDiceGroupPresenter,
	#superclass : #DynamicComposablePresenter,
	#instVars : [
		'dicePresenters'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #specs }
LoDiceGroupPresenter class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :column |  ];
		yourself
]

{ #category : #example }
LoDiceGroupPresenter class >> example [
	<example>
	| presenter diceGroup |
	presenter := self new.
	diceGroup := LoDiceGroup withDiceCount: 3.
	presenter linkTo: diceGroup.
	presenter openWithSpec.
	^ presenter
]

{ #category : #protocol }
LoDiceGroupPresenter >> addPresenterForDice: aDice [ 
	| dicePresenter |
	dicePresenter := LoDicePresenter new.
	dicePresenter linkTo: aDice.
	dicePresenters add: dicePresenter.
	dicePresenter owner: self.
	self rebuildWidget
]

{ #category : #accessing }
LoDiceGroupPresenter >> createWidgets [
	dicePresenters withIndexDo: [ :each :i | 
			self assign: each to: ('diceDisplay' , i asString) asSymbol.
			 ]
]

{ #category : #protocol }
LoDiceGroupPresenter >> default: aButton [
	aButton privateSetState: true.
	aButton takeKeyboardFocus.
	aButton
		whenBuiltDo: [ aButton privateSetState: true.
			self currentActivated: aButton]
	
]

{ #category : #accessing }
LoDiceGroupPresenter >> dicePresenters [
	^ dicePresenters
]

{ #category : #specs }
LoDiceGroupPresenter >> dynamicLayout [
	|lay|
	lay := SpecLayout composed newRow: [ : mainRow | 
		widgets keysDo: [ :item | mainRow add: item ]
	].
	self layout: lay.
	^ lay
]

{ #category : #initialization }
LoDiceGroupPresenter >> initialize [
	dicePresenters := OrderedCollection new.
	super initialize.
]

{ #category : #initialization }
LoDiceGroupPresenter >> initializePresenter [
	^self
]

{ #category : #initialization }
LoDiceGroupPresenter >> linkTo: aDiceGroup [
	aDiceGroup dice do: [ : aDice | self addPresenterForDice: aDice].
	aDiceGroup 
		afterAddToCollection: #dice 
		do: [ : newDice | self addPresenterForDice: newDice ].
	aDiceGroup 
		afterRemoveFromCollection: #dice 
		do: [ : oldDice : oldDiceIndex | self removePresenterAt: oldDiceIndex ].

]

{ #category : #accessing }
LoDiceGroupPresenter >> rebuildWidget [
	self widgets removeAll.
	self createWidgets.
	self needFullRebuild: false.
	self buildWithSpecLayout: self dynamicLayout
]

{ #category : #protocol }
LoDiceGroupPresenter >> removePresenterAt: index [ 
	dicePresenters removeAt: index.
	self rebuildWidget
]

{ #category : #api }
LoDiceGroupPresenter >> title [
	^'Dice Group'
]
