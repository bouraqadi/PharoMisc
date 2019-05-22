Class {
	#name : #LoDiceSet,
	#superclass : #LoSubject,
	#instVars : [
		'dice',
		'total'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #'instance creation' }
LoDiceSet class >> with: dice [
	^self new
		dice: dice;
		yourself
]

{ #category : #'instance creation' }
LoDiceSet class >> withDiceCount: count [
	| dice |
	dice := (1 to: count) collect: [: each | LoDice basic].
	^self with: dice
]

{ #category : #'instance creation' }
LoDiceSet class >> withTwoDice [
	^self withDiceCount: 2
]

{ #category : #'initialize-release' }
LoDiceSet >> dice: aCollection [
	dice := aCollection 
]

{ #category : #playing }
LoDiceSet >> roll [
	| newTotal |
	dice do: [: each | each roll].
	newTotal :=dice inject: 0 into: [ : sum : each | sum + each faceUp].
	^self total: newTotal
]

{ #category : #playing }
LoDiceSet >> total [
	^total
]

{ #category : #'private-generated' }
LoDiceSet >> total: anObject [
	total := anObject
]
