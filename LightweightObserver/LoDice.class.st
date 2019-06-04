"
I represent a dice with many faces, one and only one is always up.
See class side example methods in LoDicePresenter

Public API and Key Messages
- roll
Randomly choose the face up among my faces   

- faceUp 
Answers the current face up

- how to create instances.
-- faces: aCollection
Creates a dice where faces are objects of the collection

-- of: numberOfFaces
Creates a dice with the provided number of faces. Each face is a number starting from 1 and up to numberOfFaces 
 
Internal Representation and Key Implementation Points.

    Instance Variables
	faceUp:		<Object>
	faces:		<Collection of Object>


    Implementation Points
Rolling a dice = defines the faceUp using the atRandom = uses the global shared random number generator
"
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
LoDice >> defaultFacesCount [
	^6
]

{ #category : #playing }
LoDice >> faceUp [
	^faceUp
]

{ #category : #playing }
LoDice >> faceUp: currentFace [
	^faceUp := currentFace
]

{ #category : #accessing }
LoDice >> faces [
	^faces
]

{ #category : #initialization }
LoDice >> faces: aCollection [
	faces := aCollection.
	self roll
]

{ #category : #accessing }
LoDice >> facesCount [
	^self faces size
]

{ #category : #initialization }
LoDice >> facesCount: faceMaxValue [
	self faces: (1 to: faceMaxValue)
]

{ #category : #initialization }
LoDice >> initialize [
	super initialize.
	self facesCount: self defaultFacesCount
]

{ #category : #playing }
LoDice >> roll [
	^self faceUp: self faces atRandom
]
