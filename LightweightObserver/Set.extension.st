Extension { #name : #Set }

{ #category : #'*LightweightObserver' }
Set >> asSubject [
	LoSubjectSet adoptInstance: self

]
