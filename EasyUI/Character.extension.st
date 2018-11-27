Extension { #name : #Character }

{ #category : #'*EasyUI' }
Character >> asKeyCombination [
	| lowerCaseCombination |
	self asLowercase = self ifTrue: [^ KMSingleKeyCombination from: self].
	lowerCaseCombination := KMSingleKeyCombination from: self asLowercase.
	^KMModifiedKeyCombination modifier: KMModifier shift character: lowerCaseCombination.
]
