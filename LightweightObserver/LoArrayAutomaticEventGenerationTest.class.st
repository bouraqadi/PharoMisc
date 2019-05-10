Class {
	#name : #LoArrayAutomaticEventGenerationTest,
	#superclass : #LoAutomaticEventGenerationTest,
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoArrayAutomaticEventGenerationTest >> testAtPut [
	| lastRemovedValue lastAddedValue lastIndex|
	subject collection: { 11. 21. 31. }.
	subject 
		afterReplaceInCollection: #collection 
		do: [ : index : addedValue : removedValue | 
			lastIndex := index.
			lastRemovedValue := removedValue.
			lastAddedValue := addedValue].
	subject collection at: 1 put: 10.
	self assert: lastRemovedValue equals: 11.
	self assert: lastAddedValue equals: 10.
	self assert: lastIndex equals: 1.
	subject collection at: 2 put: 20.
	self assert: lastRemovedValue equals: 21.
	self assert: lastAddedValue equals: 20.
	self assert: lastIndex equals: 2.
	
]

{ #category : #testing }
LoArrayAutomaticEventGenerationTest >> testReset [
	| lastRemovedValue lastAddedValue lastIndex|
	subject collection: #(a b c).
	subject 
		afterReplaceInCollection: #collection 
		do: [ : index : addedValue : removedValue| 
			lastIndex := index.
			lastRemovedValue := removedValue.
			lastAddedValue := addedValue].
	subject collection: { 11. 21. 31. }.
	subject collection at: 1 put: 10.
	self assert: lastRemovedValue equals: 11.
	self assert: lastAddedValue equals: 10.
	self assert: lastIndex equals: 1.
	subject collection at: 2 put: 20.
	self assert: lastRemovedValue equals: 21.
	self assert: lastAddedValue equals: 20.
	self assert: lastIndex equals: 2.

]
