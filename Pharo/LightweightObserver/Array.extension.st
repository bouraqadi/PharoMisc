Extension { #name : #Array }

{ #category : #'*LightweightObserver' }
Array >> asSubject [
	| subject |
	subject := LoSubjectArray new: self size.
	self withIndexDo: [ : value : index | subject at: index put: value ].
	self becomeForward: subject.


]
