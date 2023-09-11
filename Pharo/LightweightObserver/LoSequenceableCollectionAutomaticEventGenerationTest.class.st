Class {
	#name : #LoSequenceableCollectionAutomaticEventGenerationTest,
	#superclass : #LoElasticCollectionAutomaticEventGenerationTest,
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoSequenceableCollectionAutomaticEventGenerationTest class >> isAbstract [
	^self == LoSequenceableCollectionAutomaticEventGenerationTest
]

{ #category : #testing }
LoSequenceableCollectionAutomaticEventGenerationTest >> testRemoveElementByIndex [
	| lastRemovedValue lastIndex |
	subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
	subject afterRemoveFromCollection: #collection do: [ : removedValue : index | 
		lastRemovedValue := removedValue.
		lastIndex := index].
	subject collection removeFirst.
	self assert: lastRemovedValue equals: 11.
	self assert: lastIndex equals: 1.
	subject collection removeLast.
	self assert: lastRemovedValue equals: 33.
	self assert: lastIndex equals: 6.
	subject collection removeAt: 2.
	self assert: lastRemovedValue equals: 13.
	self assert: lastIndex equals: 2.

]

{ #category : #testing }
LoSequenceableCollectionAutomaticEventGenerationTest >> testRemoveElementByIndexWithoutEventDispatch [
	subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
	self 
		shouldnt: [
			subject collection removeFirst.
			subject collection removeLast.
			subject collection removeAt: 2.
			] 
		raise: Error.

]

{ #category : #testing }
LoSequenceableCollectionAutomaticEventGenerationTest >> testRemoveOneElementWithIndex [
	| lastRemovedValue lastIndex |
	subject collection addAll: { 11. 12. 13. 20. 31. 32. 33 }.
	subject afterRemoveFromCollection: #collection do: [ : removedValue  : index | 
		lastRemovedValue := removedValue.
		lastIndex := index].
	subject collection remove: 100 ifAbsent: [].
	self assert: lastRemovedValue isNil.
	self assert: lastIndex isNil.
	subject collection remove: 20.
	self assert: lastRemovedValue equals: 20.
	self assert: lastIndex equals: 4.
	subject collection remove: 13.
	self assert: lastRemovedValue equals: 13.
	self assert: lastIndex equals: 3.
	subject collection remove: 31.
	self assert: lastRemovedValue equals: 31.
	self assert: lastIndex equals: 3.

]
