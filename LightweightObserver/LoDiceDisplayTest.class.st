Class {
	#name : #LoDiceDisplayTest,
	#superclass : #TestCase,
	#category : #'LightweightObserver-Example'
}

{ #category : #tests }
LoDiceDisplayTest >> testDiceObservedByDisplay [
	| dice diceDisplay |
	dice := LoDice basic.
	diceDisplay := LoDiceDisplay new.
	3 timesRepeat: [
		dice roll.
		self deny: diceDisplay diceValue equals: dice faceUp asString].
	diceDisplay observe: dice.
	3 timesRepeat: [
		dice roll.
		self assert: diceDisplay diceValue equals: dice faceUp asString].

]

{ #category : #tests }
LoDiceDisplayTest >> testDiceSetObservedByDisplay [
	| diceSet diceSetDisplay |
	diceSet := LoDiceSet withDiceCount: 5.
	diceSetDisplay := LoDiceSetDisplay new.
	self assert: diceSetDisplay diceDisplays isEmpty.
	diceSet roll.
	self assert: diceSetDisplay diceDisplays isEmpty.
	self deny: diceSetDisplay totalValue equals: diceSet total asString.
	diceSetDisplay observe: diceSet.
	self assert: diceSetDisplay diceDisplays size equals: 5.
	3 timesRepeat: [
		diceSet roll.
		self assert: diceSetDisplay totalValue equals: diceSet total asString].

]
