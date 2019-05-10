Trait {
	#name : #LoTMapAccessSubjectCollection,
	#traits : 'LoTSubjectCollection',
	#classTraits : 'LoTSubjectCollection classTrait',
	#category : #'LightweightObserver-Collections'
}

{ #category : #accessing }
LoTMapAccessSubjectCollection >> at: key put: addedObject [
	| removedObject event |
	self dispatcher ifNil: [^super at: key put: addedObject].
	removedObject := self at: key ifAbsent: [nil].
	super at: key put: addedObject.
	event := LoSingleElementReplaceEvent at: key replaced: removedObject by: addedObject.
	self dispatcher dispatch: event.
	^ addedObject
]

{ #category : #accessing }
LoTMapAccessSubjectCollection >> dispatcher [
	self explicitRequirement
]

{ #category : #accessing }
LoTMapAccessSubjectCollection >> dispatcher: anObject [
	self explicitRequirement
]
