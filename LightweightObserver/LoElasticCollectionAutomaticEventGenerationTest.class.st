Class {
	#name : #LoElasticCollectionAutomaticEventGenerationTest,
	#superclass : #LoAutomaticEventGenerationTest,
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest class >> isAbstract [
	^self == LoElasticCollectionAutomaticEventGenerationTest
]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> collectionClass [
	self subclassResponsibility
]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> newCollection [
	^self collectionClass new
]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> setUp [
	super setUp.
	subject collection: self newCollection
]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> testAddManyElements [
	| addedObjects recordedObjects |
	recordedObjects := OrderedCollection new.
	subject afterAddToCollection: #collection do: [ : newValue | recordedObjects add: newValue].
	addedObjects := 1 to: 10.
	subject collection addAll: addedObjects.
	self assertCollection: recordedObjects hasSameElements: addedObjects.
]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> testAddOneElement [
	| lastAddedValue |
	subject afterAddToCollection: #collection do: [ : newValue | lastAddedValue := newValue].
	subject collection add: #monday.
	self assert: lastAddedValue equals: #monday.
	subject collection add: #sunday.
	self assert: lastAddedValue equals: #sunday.

]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> testArbitraryChange [
	| changeCount |
	changeCount := 0.
	subject afterChangeOfCollection: #collection do: [changeCount := changeCount + 1].
	subject collection add: #monday.
	self assert: changeCount equals: 1.
	subject collection remove: #monday.
	self assert: changeCount equals: 2.

]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> testRemoveManyObjects [
	| removedObjects recordedObjects |
	subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
	recordedObjects := OrderedCollection new.
	subject afterRemoveFromCollection: #collection do: [ : newValue | recordedObjects add: newValue].
	removedObjects := {11. 13. 20. 32}.
	subject collection removeAll: removedObjects.
	self assertCollection: recordedObjects hasSameElements: removedObjects.
]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> testRemoveOneElement [
	| lastRemovedValue |
	subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
	subject afterRemoveFromCollection: #collection do: [ : removedValue | lastRemovedValue := removedValue].
	subject collection remove: 100 ifAbsent: [].
	self assert: lastRemovedValue isNil.
	subject collection remove: 20.
	self assert: lastRemovedValue equals: 20.
	subject collection remove: 13.
	self assert: lastRemovedValue equals: 13.

]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> testRemoveOneElementWithoutEventDispatch [
	subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
	self 
		shouldnt: [
			subject collection remove: 100 ifAbsent: [].
			subject collection remove: 11.
			subject collection remove: 33.
			] 
		raise: Error.

]

{ #category : #testing }
LoElasticCollectionAutomaticEventGenerationTest >> testReset [
	| doneAddition |
	doneAddition := false.
	subject afterAddToCollection: #collection do: [doneAddition := true].
	subject collection: self newCollection.	
	subject collection addAll: #(1 2).
	self assert: doneAddition.
	
]
