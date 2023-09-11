Extension { #name : #Collection }

{ #category : #'*BooleanExpressions' }
Collection >> allFalse [
	self ifEmpty: [ ^false ].
	^self noneSatisfy: [ :each| each value ]
]

{ #category : #'*BooleanExpressions' }
Collection >> allTrue [
	self ifEmpty: [ ^false ].
	^self allSatisfy: [ :each| each value ]
]

{ #category : #'*BooleanExpressions' }
Collection >> anyFalse [
	^self anySatisfy: [ :each| each value not ]
]

{ #category : #'*BooleanExpressions' }
Collection >> anyTrue [
	^self anySatisfy: [ :each| each value ]
]
