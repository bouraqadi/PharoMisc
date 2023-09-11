Extension { #name : #Number }

{ #category : #'*PharoExtra-Chronology' }
Number >> month [
	^self months
]

{ #category : #'*PharoExtra-Chronology' }
Number >> months [
	^Duration months: self
]
