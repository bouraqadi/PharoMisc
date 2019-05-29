Class {
	#name : #LoDiceGame,
	#superclass : #Object,
	#instVars : [
		'diceSet',
		'players',
		'probabilityDistribution'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #accessing }
LoDiceGame >> diceSet [
	^diceSet 
]

{ #category : #'initialize-release' }
LoDiceGame >> initialize [
	super initialize.
	diceSet := LoDiceGroup withTwoDice.
	probabilityDistribution := LoProbabilityDistribution new.
	diceSet afterChangeOf: #total do: [: diceTotal | probabilityDistribution updateOccurenceCountFor: diceTotal ]
	
]

{ #category : #accessing }
LoDiceGame >> players [
	^ players
]

{ #category : #'initialize-release' }
LoDiceGame >> players: aCollection [
	players := aCollection.
	players do: [ : each |
		diceSet afterChangeOf: #total do: [: diceTotal | each updateScoreForDiceTotal: diceTotal ] ]
]

{ #category : #accessing }
LoDiceGame >> probabilityDistribution [
	^probabilityDistribution
]
