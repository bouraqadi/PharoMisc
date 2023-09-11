Class {
	#name : #LoOrderedCollectionAutomaticEventGenerationTest,
	#superclass : #LoSequenceableCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoOrderedCollectionAutomaticEventGenerationTest >> collectionClass [
	^OrderedCollection
]

{ #category : #testing }
LoOrderedCollectionAutomaticEventGenerationTest >> testAddFirstAndLastElement [
	| lastAddedValue lastIndex |
	subject afterAddToCollection: #collection do: [ : newValue : newIndex| 
		lastAddedValue := newValue.
		lastIndex := newIndex].
	subject collection addLast: #saturday.
	self assert: lastAddedValue equals: #saturday.
	self assert: lastIndex equals: 1.
	subject collection addFirst: #sunday.
	self assert: lastAddedValue equals: #sunday.
	self assert: lastIndex equals: 1.
	subject collection addLast: #monday.
	self assert: lastAddedValue equals: #monday.
	self assert: lastIndex equals: 3.

]

{ #category : #testing }
LoOrderedCollectionAutomaticEventGenerationTest >> testAddOneElementWithIndex [
	| lastAddedValue lastIndex |
	subject afterAddToCollection: #collection do: [ : newValue : newIndex| 
		lastAddedValue := newValue.
		lastIndex := newIndex].
	subject collection add: #monday.
	self assert: lastAddedValue equals: #monday.
	self assert: lastIndex equals: 1.
	subject collection add: #sunday.
	self assert: lastAddedValue equals: #sunday.
	self assert: lastIndex equals: 2.

]

{ #category : #testing }
LoOrderedCollectionAutomaticEventGenerationTest >> testArbitraryChangeWithFirstLastElementManipulation [
	| changeCount |
	changeCount := 0.
	subject afterChangeOfCollection: #collection do: [changeCount := changeCount + 1].
	subject collection add: #monday.
	self assert: changeCount equals: 1.
	subject collection addFirst: #sunday.
	self assert: changeCount equals: 2.
	subject collection addLast: #saturday.
	self assert: changeCount equals: 3.
	subject collection remove: #monday.
	self assert: changeCount equals: 4.
	subject collection at: 1 put: #friday.
	self assert: changeCount equals: 5.

]

{ #category : #testing }
LoOrderedCollectionAutomaticEventGenerationTest >> testAtPut [
	| lastRemovedValue lastAddedValue lastIndex|
	subject collection addAll: { 11. 21. 31. }.
	subject 
		afterReplaceInCollection: #collection 
		do: [ : index : addedValue : removedValue | 
			lastIndex := index.
			lastAddedValue := addedValue.
			lastRemovedValue := removedValue.
			].
	subject collection at: 1 put: 10.
	self assert: lastRemovedValue equals: 11.
	self assert: lastAddedValue equals: 10.
	self assert: lastIndex equals: 1.
	subject collection at: 2 put: 20.
	self assert: lastRemovedValue equals: 21.
	self assert: lastAddedValue equals: 20.
	self assert: lastIndex equals: 2.
	
]
