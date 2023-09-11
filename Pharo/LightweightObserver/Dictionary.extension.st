Extension { #name : #Dictionary }

{ #category : #'*LightweightObserver' }
Dictionary >> asSubject [
	LoSubjectDictionary adoptInstance: self
]
