Class {
	#name : #MmNormalRemoteResponse,
	#superclass : #MmRemoteResponse,
	#instVars : [
		'result'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmNormalRemoteResponse class >> id: id result: result [
	^self new
		id: id;
		result: result;
		yourself
]

{ #category : #accessing }
MmNormalRemoteResponse >> result [
	^ result
]

{ #category : #accessing }
MmNormalRemoteResponse >> result: anObject [
	result := anObject
]

{ #category : #acting }
MmNormalRemoteResponse >> trigger: aPromise [
	aPromise fulfillWith: self result
]
