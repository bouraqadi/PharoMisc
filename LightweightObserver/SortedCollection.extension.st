Extension { #name : #SortedCollection }

{ #category : #'*LightweightObserver' }
SortedCollection >> asSubject [
	LoSubjectSortedCollection adoptInstance: self

]
