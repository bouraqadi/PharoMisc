Trait {
	#name : #LoTSequeceableSubjectCollection,
	#traits : 'LoTElasticSubjectCollection',
	#classTraits : 'LoTElasticSubjectCollection classTrait',
	#category : #'LightweightObserver-Collections'
}

{ #category : #adding }
LoTSequeceableSubjectCollection >> addLast: anObject [
	super addLast: anObject.
	self dispatchEventAdded: anObject at: self size.
	^ anObject
]

{ #category : #accessing }
LoTSequeceableSubjectCollection >> dispatcher [
	self explicitRequirement
]

{ #category : #accessing }
LoTSequeceableSubjectCollection >> dispatcher: anObject [
	self explicitRequirement
]

{ #category : #removing }
LoTSequeceableSubjectCollection >> remove: anObject ifAbsent: aBlock [
	| index |
	index := self indexOf: anObject.
	super remove: anObject ifAbsent: [^aBlock value].
	self dispatchEventRemoved: anObject at: index.
	^ anObject
]

{ #category : #removing }
LoTSequeceableSubjectCollection >> removeAt: index [
	| removedObject |
	removedObject := super removeAt: index.
	self dispatchEventRemoved: removedObject at: index.
	^ removedObject
]

{ #category : #removing }
LoTSequeceableSubjectCollection >> removeFirst [
	| removedObject |
	removedObject := super removeFirst.
	self dispatchEventRemoved: removedObject at: 1.
	^ removedObject
]

{ #category : #removing }
LoTSequeceableSubjectCollection >> removeLast [
	| removedObject index |
	index := self size.
	removedObject := super removeLast.
	self dispatchEventRemoved: removedObject at: index.
	^ removedObject
]
