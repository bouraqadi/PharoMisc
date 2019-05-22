Class {
	#name : #LoDiceGameTest,
	#superclass : #TestCase,
	#instVars : [
		'playerA',
		'playerB',
		'game',
		'diceSet',
		'probabilityDistribution'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #running }
LoDiceGameTest >> setUp [
	super setUp.
	playerA := LoPlayer new.
	playerB := LoPlayer new.
	game := LoDiceGame new.
	game players: { playerA. playerB }.
	diceSet := game diceSet.
	probabilityDistribution := game probabilityDistribution.
	

]

{ #category : #tests }
LoDiceGameTest >> testBothPlayersLose [
	playerA target: 10.
	playerB target: 4.
	diceSet total: 6.
	self assert: playerA score equals: -1.
	self assert: playerB score equals: -1.

]

{ #category : #tests }
LoDiceGameTest >> testBothPlayersWin [
	playerA target: 9.
	playerB target: 9.
	diceSet total: 9.
	self assert: playerA score equals: 4.
	self assert: playerB score equals: 4.

]

{ #category : #tests }
LoDiceGameTest >> testMultipleRoundsPlayerAWins [
	playerA target: 7.
	playerB target: 2.
	#(7 3 2 7 2 5 7) do: [: each | diceSet total: each  ].
	self assert: playerA score equals: 8.
	self assert: playerB score equals: 3.
	#(4 6 8 9 10 11 12) do: [ : each |
		self assert: (probabilityDistribution probabilityToGet: each) equals: 0 ].
	self assert: (probabilityDistribution probabilityToGet: 7) equals: 3/7.
	self assert: (probabilityDistribution probabilityToGet: 2) equals: 2/7.
	#(3 5) do: [ : each |
		self assert: (probabilityDistribution probabilityToGet: each) equals: 1/7 ].
	

]

{ #category : #tests }
LoDiceGameTest >> testMultipleRoundsPlayerBWins [
	playerA target: 7.
	playerB target: 2.
	#(2 2 2 12 2 11 5 2 6 2 7 2 12) do: [: each | diceSet total: each  ].
	self assert: playerA score equals: -8.
	self assert: playerB score equals: 22.
	#(3 4 8 9 10) do: [ : each |
		self assert: (probabilityDistribution probabilityToGet: each) equals: 0 ].
	self assert: (probabilityDistribution probabilityToGet: 2) equals: 7/13.
	self assert: (probabilityDistribution probabilityToGet: 12) equals: 2/13.
	#(11 5 6 7) do: [ : each |
		self assert: (probabilityDistribution probabilityToGet: each) equals: 1/13 ].
	

]

{ #category : #tests }
LoDiceGameTest >> testPlayerAWins [
	playerA target: 7.
	playerB target: 2.
	diceSet total: 7.
	self assert: playerA score equals: 4.
	self assert: playerB score equals: -1.

]

{ #category : #tests }
LoDiceGameTest >> testPlayerBWins [
	playerA target: 7.
	playerB target: 2.
	diceSet total: 2.
	self assert: playerA score equals: -1.
	self assert: playerB score equals: 4.

]
