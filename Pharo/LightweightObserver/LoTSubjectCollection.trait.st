Trait {
	#name : #LoTSubjectCollection,
	#category : #'LightweightObserver-Collections'
}

{ #category : #converting }
LoTSubjectCollection >> asSubject [
	^self
]

{ #category : #accessing }
LoTSubjectCollection >> dispatcher [
	self explicitRequirement
]

{ #category : #accessing }
LoTSubjectCollection >> dispatcher: anObject [
	self explicitRequirement
]
