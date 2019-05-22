Class {
	#name : #LoProbabilityDistribution,
	#superclass : #Object,
	#instVars : [
		'occurencesDict'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #'initialize-release' }
LoProbabilityDistribution >> initialize [
	super initialize.
	occurencesDict := Dictionary new.
]

{ #category : #probabilities }
LoProbabilityDistribution >> occurencesCountFor: anObject [ 
	^occurencesDict at: anObject ifAbsent: [ 0 ]
]

{ #category : #probabilities }
LoProbabilityDistribution >> probabilityToGet: anObject [ 
	^(self occurencesCountFor: anObject) / self totalOccurences
]

{ #category : #probabilities }
LoProbabilityDistribution >> totalOccurences [
	^occurencesDict values sum
]

{ #category : #probabilities }
LoProbabilityDistribution >> updateOccurenceCountFor: anObject [
	| newCount |
	newCount := self occurencesCountFor: anObject.
	^occurencesDict at: anObject put: newCount +1
]
