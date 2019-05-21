Class {
	#name : #LoDiceSet,
	#superclass : #LoSubject,
	#instVars : [
		'dice'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #accessing }
LoDiceSet >> dice: aCollection [
	dice := aCollection 
]
