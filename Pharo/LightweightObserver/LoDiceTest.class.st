Class {
	#name : #LoDiceTest,
	#superclass : #TestCase,
	#instVars : [
		'dice'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #running }
LoDiceTest >> assertFaceUpBelongsToFaces: faceValues [
	| faceUp |
	dice faces: faceValues.
	100
		timesRepeat: [ faceUp := dice roll.
			(faceValues includes: faceUp)
				ifFalse: [ self fail: 'Dice face up should belong to faces collection' ] ]
]

{ #category : #running }
LoDiceTest >> setUp [
	super setUp.
	dice := LoDice new.
]

{ #category : #running }
LoDiceTest >> testCreation [
	| userDefinedFaces |
	dice := LoDice new.
	self assert: dice faces equals: (1 to: 6).

	2 to: 32 do: [ : facesCount |
		dice := LoDice of: facesCount.
		self assert: dice faces equals: (1 to: facesCount).
	].

	userDefinedFaces := #(a b c).
	dice := LoDice faces: userDefinedFaces.
	self assert: dice faces equals: userDefinedFaces.

	userDefinedFaces := #(a a a b).
	dice := LoDice faces: userDefinedFaces.
	self assert: dice faces equals: userDefinedFaces.


]

{ #category : #running }
LoDiceTest >> testFaceUpBelongsToDiceFaces [ 
	self assertFaceUpBelongsToFaces: #(a b).
	self assertFaceUpBelongsToFaces: #(z a x).
	dice facesCount: 12.
	self assert: dice faces equals: (1 to: 12).
	self assertFaceUpBelongsToFaces: dice faces.
	
]

{ #category : #running }
LoDiceTest >> testFaceUpChangesUponRolls [
	|oldFaceUp |
	oldFaceUp := dice faceUp.
	100 timesRepeat: [
		dice roll.
		oldFaceUp = dice faceUp ifFalse: [^true].
		oldFaceUp := dice faceUp.
	].
	self fail: 'Dice face up should change upon roll'
]

{ #category : #running }
LoDiceTest >> testObserver [
	|observedValue|
	dice afterChangeOf: #faceUp do: [ : newFaceUp | observedValue := newFaceUp ].
	10 timesRepeat: [
		dice roll.
		self assert: observedValue equals: dice faceUp
	].
]
