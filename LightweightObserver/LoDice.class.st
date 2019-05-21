Class {
	#name : #LoDice,
	#superclass : #LoSubject,
	#instVars : [
		'faceUp',
		'faces'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #'instance creation' }
LoDice class >> basic [
	^self of: 6
]

{ #category : #'instance creation' }
LoDice class >> faces: faces [
	^self new
		faces: faces;
		yourself
]

{ #category : #'instance creation' }
LoDice class >> of: facesCount [
	^self faces: (1 to: facesCount)
]

{ #category : #initialization }
LoDice >> faces [
	^faces
]

{ #category : #initialization }
LoDice >> faces: aCollection [
	faces := aCollection
]

{ #category : #initialization }
LoDice >> facesCount [
	^self faces size
]

{ #category : #initialization }
LoDice >> facesCount: faceMaxValue [
	self faces: (1 to: faceMaxValue)
]

{ #category : #initialization }
LoDice >> roll [
	^faceUp := self faces atRandom
]
