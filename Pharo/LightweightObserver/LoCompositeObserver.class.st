"
Composite observer. I am actually a collection of observers that are my children.

    Instance Variables
	children:		<Collection of observers>

"
Class {
	#name : #LoCompositeObserver,
	#superclass : #Object,
	#instVars : [
		'children'
	],
	#category : #'LightweightObserver-Kernel'
}

{ #category : #'instance creation' }
LoCompositeObserver class >> children: aCollection [ 
	^self new
		children: aCollection;
		yourself
]

{ #category : #accessing }
LoCompositeObserver >> children [
	^ children
]

{ #category : #accessing }
LoCompositeObserver >> children: anObject [
	children := anObject
]

{ #category : #observing }
LoCompositeObserver >> startObserving [
	self children do: [ : each | each startObserving ]
]

{ #category : #observing }
LoCompositeObserver >> stopObserving [
	self children do: [ : each | each stopObserving ]
]
