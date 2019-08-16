Class {
	#name : #CcBlockEvaluator,
	#superclass : #Object,
	#instVars : [
		'valueBlock'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #accessing }
CcBlockEvaluator class >> valueBlock: aBlock [
	^self new
		valueBlock: aBlock;
		yourself
]

{ #category : #'reflective operations' }
CcBlockEvaluator >> doesNotUnderstand: aMessage [
	^valueBlock value
]

{ #category : #sending }
CcBlockEvaluator >> perform: selector withArguments: arguments [
	^valueBlock value
]

{ #category : #accessing }
CcBlockEvaluator >> valueBlock: aBlock [
	valueBlock := aBlock
]
