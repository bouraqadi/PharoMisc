Class {
	#name : #LoPlayer,
	#superclass : #Object,
	#instVars : [
		'score',
		'target'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #'initialize-release' }
LoPlayer >> initialize [
	super initialize.
	self resetScore
]

{ #category : #'initialize-release' }
LoPlayer >> resetScore [
	score := 0
]

{ #category : #accessing }
LoPlayer >> score [
	^ score
]

{ #category : #accessing }
LoPlayer >> target [
	^ target
]

{ #category : #accessing }
LoPlayer >> target: anObject [
	target := anObject
]

{ #category : #scoring }
LoPlayer >> updateScoreForDiceTotal: total [
	|deltaScore|
	deltaScore := self target = total ifTrue: [ 4 ] ifFalse: [ -1 ].
	score := self score + deltaScore
]
