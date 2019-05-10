Class {
	#name : #LoSortedCollectionAutomaticEventGenerationTest,
	#superclass : #LoSequenceableCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoSortedCollectionAutomaticEventGenerationTest >> collectionClass [
	^SortedCollection
]

{ #category : #testing }
LoSortedCollectionAutomaticEventGenerationTest >> testAddLastElement [
	| lastAddedValue lastIndex |
	subject afterAddToCollection: #collection do: [ : newValue : newIndex| 
		lastAddedValue := newValue.
		lastIndex := newIndex].
	subject collection addLast: #sunday.
	self assert: lastAddedValue equals: #sunday.
	self assert: lastIndex equals: 1.
	subject collection addLast: #saturday.
	self assert: lastAddedValue equals: #saturday.
	self assert: lastIndex equals: 2

]

{ #category : #testing }
LoSortedCollectionAutomaticEventGenerationTest >> testAddOneElementWithIndex [
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
	subject collection add: #saturday.
	self assert: lastAddedValue equals: #saturday.
	self assert: lastIndex equals: 2.
	subject collection add: #wednesday.
	self assert: lastAddedValue equals: #wednesday.
	self assert: lastIndex equals: 4.

]

{ #category : #testing }
LoSortedCollectionAutomaticEventGenerationTest >> testArbitraryChangeWithLastElementManipulation [
	| changeCount |
	changeCount := 0.
	subject afterChangeOfCollection: #collection do: [changeCount := changeCount + 1].
	subject collection add: 10.
	self assert: changeCount equals: 1.
	subject collection addLast: 5.
	self assert: changeCount equals: 2.
	subject collection addLast: 4.
	self assert: changeCount equals: 3.
	subject collection remove: 10.
	self assert: changeCount equals: 4.

]

{ #category : #testing }
LoSortedCollectionAutomaticEventGenerationTest >> testElementsStaySorted [
	subject afterChangeOfCollection: #collection do: [].
	#(10 5 1) do: [ : each |
		subject collection add: each ].
	self assert: subject collection first equals: 1.
	self assert: subject collection last equals: 10.
]
