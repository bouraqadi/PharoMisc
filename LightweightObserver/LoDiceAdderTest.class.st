Class {
	#name : #LoDiceAdderTest,
	#superclass : #TestCase,
	#instVars : [
		'diceAdder'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #tests }
LoDiceAdderTest >> testTotalReflectsFacesUp [
	diceAdder := LoDiceAdder withTwoDice.
	1 to: 6 do: [ : diceValue|
		diceAdder dice do: [ : each | each faceUp: diceValue ].
		self assert: diceAdder total equals: diceValue * 2
		 ]

]

{ #category : #tests }
LoDiceAdderTest >> testTotalUpdatedUponAddingDice [
	| oldTotal newDice expectedTotal |
	diceAdder := LoDiceAdder new.
	self assert: diceAdder total equals: 0.
	oldTotal := 0.
	10 timesRepeat: [ 
		diceAdder addDice.
		newDice := diceAdder dice last.
		expectedTotal := oldTotal + newDice faceUp.
		self assert: diceAdder total equals: expectedTotal.
		oldTotal := expectedTotal.
	]

]

{ #category : #tests }
LoDiceAdderTest >> testTotalUpdatedUponAddingDiceDirectlyToCollection [
	| newDice expectedTotal |
	diceAdder := LoDiceAdder new.
	expectedTotal := 0.
	10 timesRepeat: [ 
		newDice := LoDice of: 100.
		newDice faceUp: 1.
		diceAdder dice add: newDice.
		self assert: diceAdder total equals: expectedTotal + 1.
		newDice faceUp: 100.
		expectedTotal := expectedTotal + 100.
		self assert: diceAdder total equals: expectedTotal.
	]

]

{ #category : #tests }
LoDiceAdderTest >> testTotalUpdatedUponInsertingDice [
	| insertedDice |
	diceAdder := LoDiceAdder withDiceCount: 10.
	diceAdder dice do: [ : each | each faceUp: 1 ].
	self assert: diceAdder total equals: 10.
	#(1 5 10) with: #(109 208 307) do: [ : index : expectedTotal|
		insertedDice := LoDice of: 100.
		insertedDice faceUp: 1.
		diceAdder dice at: index put: insertedDice.
		self assert: diceAdder total equals: expectedTotal - 99.
		insertedDice faceUp: 100.
		self assert: diceAdder total equals: expectedTotal.
	]

]

{ #category : #tests }
LoDiceAdderTest >> testTotalUpdatedUponRemovingDice [
	| oldTotal oldDice expectedTotal |
	diceAdder := LoDiceAdder withDiceCount: 10.
	oldTotal := diceAdder total.
	10 timesRepeat: [ 
		oldDice := diceAdder dice last.
		diceAdder removeDice.
		expectedTotal := oldTotal - oldDice faceUp.
		self assert: diceAdder total equals: expectedTotal.
		oldTotal := expectedTotal.
	]

]

{ #category : #tests }
LoDiceAdderTest >> testTotalUpdatedUponRemovingDiceDirectlyToCollection [
	| removedDice expectedTotal |
	diceAdder := LoDiceAdder withDiceCount: 10.
	diceAdder dice do: [ : each | each faceUp: 6 ].
	expectedTotal := 60.
	self assert: diceAdder total equals: expectedTotal.
	10 timesRepeat: [ 
		removedDice := diceAdder dice last.
		diceAdder dice remove: removedDice.
		expectedTotal := expectedTotal - removedDice faceUp.
		self assert: diceAdder total equals: expectedTotal.
	]

]

{ #category : #tests }
LoDiceAdderTest >> testTotalUpdatedUponReplaceDiceCollection [
	| newDiceArray extraDice |
	diceAdder := LoDiceAdder withDiceCount: 10.
	diceAdder dice do: [ : each | each faceUp: 6 ].
	newDiceArray := { LoDice new. LoDice new }.
	newDiceArray first faceUp: 1.
	newDiceArray last faceUp: 2.
	diceAdder dice: newDiceArray.
	self assert: diceAdder total equals: 3.
	extraDice := LoDice new.
	extraDice faceUp: 5.
	diceAdder addDice: extraDice.
	self assert: diceAdder total equals: 8.
	extraDice faceUp: 1.
	self assert: diceAdder total equals: 4.
	diceAdder removeDice: extraDice.
	self assert: diceAdder total equals: 3.


]

{ #category : #tests }
LoDiceAdderTest >> testTotalUpdatedUponRollingDice [
	| oldTotal |
	diceAdder := LoDiceAdder withDiceCount: 5.
	oldTotal := diceAdder total.
	100 timesRepeat: [ 
		diceAdder roll.
		oldTotal = diceAdder total ifFalse: [ ^self ].
	].
	self fail: 'Total should change upon rolling dice'

]

{ #category : #tests }
LoDiceAdderTest >> testTotalUponCreation [
	| newDiceArray |
	diceAdder := LoDiceAdder new.
	self assert: diceAdder total equals: 0.
	
	diceAdder := LoDiceAdder withDiceCount: 10.
	self assert: diceAdder total > 9.
	
	newDiceArray := { LoDice new. LoDice new }.
	newDiceArray first faceUp: 1.
	newDiceArray last faceUp: 2.
	diceAdder := LoDiceAdder with: newDiceArray.
	self assert: diceAdder total equals: 3.

]
