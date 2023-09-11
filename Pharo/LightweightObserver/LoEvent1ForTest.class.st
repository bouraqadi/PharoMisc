Class {
	#name : #LoEvent1ForTest,
	#superclass : #LoEvent,
	#instVars : [
		'data'
	],
	#category : #'LightweightObserver-Test'
}

{ #category : #accessing }
LoEvent1ForTest >> data [
	^ data
]

{ #category : #accessing }
LoEvent1ForTest >> data: anObject [
	data := anObject
]
