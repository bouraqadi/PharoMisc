Extension { #name : #OrderedCollection }

{ #category : #'*LightweightObserver' }
OrderedCollection >> asSubject [
	LoSubjectOrderedCollection adoptInstance: self

]
