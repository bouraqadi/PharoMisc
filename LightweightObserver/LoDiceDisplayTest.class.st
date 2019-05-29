Class {
	#name : #LoDiceDisplayTest,
	#superclass : #TestCase,
	#category : #'LightweightObserver-Example'
}

{ #category : #tests }
LoDiceDisplayTest >> testDiceObservedByDisplay [
	| dice diceDisplay |
	dice := LoDice basic.
	diceDisplay := LoDicePresenter new.
	3 timesRepeat: [
		dice roll.
		self deny: diceDisplay diceValue equals: dice faceUp asString].
	diceDisplay linkTo: dice.
	3 timesRepeat: [
		dice roll.
		self assert: diceDisplay diceValue equals: dice faceUp asString].

]

{ #category : #tests }
LoDiceDisplayTest >> testDiceSetDisplayObservesDiceAddition [
	| diceSet diceSetDisplay |
	diceSet := LoDiceGroup new.
	diceSetDisplay := LoDiceGamePresenter new.
	diceSetDisplay linkTo: diceSet.
	1 to: 5 do: [: expectedDiceDisplayCount |
		diceSet addDice: LoDice basic.
		self assert: diceSetDisplay dicePresenters size equals: expectedDiceDisplayCount.
	]

]

{ #category : #tests }
LoDiceDisplayTest >> testDiceSetDisplayObservesDiceRemoval [
	| diceSet diceSetDisplay |
	diceSet := LoDiceGroup withDiceCount: 5.
	diceSetDisplay := LoDiceGamePresenter new.
	diceSetDisplay linkTo: diceSet.
	(0 to: 4) reverseDo: [: expectedDiceDisplayCount |
		diceSet dice remove: diceSet dice last.
		self assert: diceSetDisplay dicePresenters size equals: expectedDiceDisplayCount.
	]

]

{ #category : #tests }
LoDiceDisplayTest >> testDiceSetDisplayObservesDiceRoll [
	| diceSet diceSetDisplay |
	diceSet := LoDiceGroup withDiceCount: 5.
	diceSetDisplay := LoDiceGamePresenter new.
	diceSetDisplay linkTo: diceSet.
	3 timesRepeat: [
		diceSet roll.
		self assert: diceSetDisplay totalValue equals: diceSet total asString].

]

{ #category : #tests }
LoDiceDisplayTest >> testDiceSetObservedByDisplay [
	| diceSet diceSetDisplay |
	diceSet := LoDiceGroup withDiceCount: 5.
	diceSetDisplay := LoDiceGamePresenter new.
	self assert: diceSetDisplay dicePresenters isEmpty.
	diceSet roll.
	self assert: diceSetDisplay dicePresenters isEmpty.
	self deny: diceSetDisplay totalValue equals: diceSet total asString.
	diceSetDisplay linkTo: diceSet.
	self assert: diceSetDisplay dicePresenters size equals: 5.

]
