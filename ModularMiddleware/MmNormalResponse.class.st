Class {
	#name : #MmNormalResponse,
	#superclass : #MmResponse,
	#instVars : [
		'result'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmNormalResponse class >> id: id result: result [
	^self new
		id: id;
		result: result;
		yourself
]

{ #category : #accessing }
MmNormalResponse >> result [
	^ result
]

{ #category : #accessing }
MmNormalResponse >> result: anObject [
	result := anObject
]

{ #category : #acting }
MmNormalResponse >> trigger: aPromise [
	aPromise fulfillWith: self result
]
