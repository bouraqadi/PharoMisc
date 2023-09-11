Class {
	#name : #LoSetAutomaticEventGenerationTest,
	#superclass : #LoElasticCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoSetAutomaticEventGenerationTest >> collectionClass [
	^Set
]

{ #category : #testing }
LoSetAutomaticEventGenerationTest >> testAddRedundantElement [
	| additionCount |
	additionCount := 0.
	subject afterAddToCollection: #collection do: [ additionCount := additionCount + 1].
	subject collection add: #monday.
	self assert: additionCount equals: 1.
	subject collection add: #monday.
	self assert: additionCount equals: 1.

]
