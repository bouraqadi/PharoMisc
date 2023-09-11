Class {
	#name : #LoDictionaryAutomaticEventGenerationTest,
	#superclass : #LoAutomaticEventGenerationTest,
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoDictionaryAutomaticEventGenerationTest >> testAtIfAbsentPut [
	| lastRemovedValue lastAddedValue modifiedKey|
	subject collection: Dictionary new.
	subject 
		afterReplaceInCollection: #collection 
		do: [ : key : addedValue : removedValue| 
			modifiedKey := key.
			lastRemovedValue := removedValue.
			lastAddedValue := addedValue].
	subject collection at: #a ifAbsentPut: [10].
	self assert: lastRemovedValue equals: nil.
	self assert: lastAddedValue equals: 10.
	self assert: modifiedKey equals: #a.
	subject collection at: #b ifAbsentPut: [20].
	self assert: lastRemovedValue equals: nil.
	self assert: lastAddedValue equals: 20.
	self assert: modifiedKey equals: #b.
	subject collection at: #a ifAbsentPut: [33].
	self assert: lastRemovedValue equals: nil.
	self assert: lastAddedValue equals: 20.
	self assert: modifiedKey equals: #b.

]

{ #category : #testing }
LoDictionaryAutomaticEventGenerationTest >> testAtPut [
	| lastRemovedValue lastAddedValue modifiedKey|
	subject collection: { #a->11. #b->21. #c->31. } asDictionary.
	subject 
		afterReplaceInCollection: #collection 
		do: [ : key : addedValue : removedValue| 
			modifiedKey := key.
			lastRemovedValue := removedValue.
			lastAddedValue := addedValue].
	subject collection at: #a put: 10.
	self assert: lastRemovedValue equals: 11.
	self assert: lastAddedValue equals: 10.
	self assert: modifiedKey equals: #a.
	subject collection at: #b put: 20.
	self assert: lastRemovedValue equals: 21.
	self assert: lastAddedValue equals: 20.
	self assert: modifiedKey equals: #b.
	
]

{ #category : #testing }
LoDictionaryAutomaticEventGenerationTest >> testReset [
	| lastRemovedValue lastAddedValue modifiedKey|
	subject collection: { #z->'zorro'. #x->'x men'. #s->'spider man'. } asDictionary.
	subject 
		afterReplaceInCollection: #collection 
		do: [ : key : addedValue : removedValue| 
			modifiedKey := key.
			lastRemovedValue := removedValue.
			lastAddedValue := addedValue].
	subject collection: { #a->11. #b->21. #c->31. } asDictionary.
	subject collection at: #a put: 10.
	self assert: lastRemovedValue equals: 11.
	self assert: lastAddedValue equals: 10.
	self assert: modifiedKey equals: #a.
	subject collection at: #b put: 20.
	self assert: lastRemovedValue equals: 21.
	self assert: lastAddedValue equals: 20.
	self assert: modifiedKey equals: #b.
	
]
