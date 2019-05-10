Trait {
	#name : #LoTElasticSubjectCollection,
	#traits : 'LoTSubjectCollection',
	#classTraits : 'LoTSubjectCollection classTrait',
	#category : #'LightweightObserver-Collections'
}

{ #category : #adding }
LoTElasticSubjectCollection >> dispatchEventAdded: anObject [
	| event |
	self dispatcher ifNil: [ ^self ].
	event := LoSingleElementAddEvent element: anObject.
	self dispatcher dispatch: event
]

{ #category : #adding }
LoTElasticSubjectCollection >> dispatchEventAdded: anObject at: index [
	| event |
	self dispatcher ifNil: [ ^self ].
	event := LoSingleElementAddEvent element: anObject at: index.
	self dispatcher dispatch: event
]

{ #category : #removing }
LoTElasticSubjectCollection >> dispatchEventRemoved: anObject [
	| event |
	event := LoSingleElementRemoveEvent element: anObject.
	self dispatcher dispatch: event
]

{ #category : #removing }
LoTElasticSubjectCollection >> dispatchEventRemoved: anObject at: index [
	| event |
	event := LoSingleElementRemoveEvent element: anObject at: index.
	self dispatcher dispatch: event
]

{ #category : #accessing }
LoTElasticSubjectCollection >> dispatcher [
	self explicitRequirement
]

{ #category : #accessing }
LoTElasticSubjectCollection >> dispatcher: anObject [
	self explicitRequirement
]
