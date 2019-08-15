Class {
	#name : #CcFutureException,
	#superclass : #Object,
	#instVars : [
		'exceptionBlock'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #accessing }
CcFutureException class >> exceptionBlock: aBlock [
	^self new
		exceptionBlock: aBlock;
		yourself
]

{ #category : #accessing }
CcFutureException >> exceptionBlock [
	^ exceptionBlock
]

{ #category : #accessing }
CcFutureException >> exceptionBlock: aBlock [
	exceptionBlock := aBlock
]

{ #category : #sending }
CcFutureException >> perform: selector withArguments: arguments [
	exceptionBlock value
]
