Class {
	#name : #ActiveObjectTest,
	#superclass : #TestCase,
	#traits : 'TConcurrencyTest',
	#classTraits : 'TConcurrencyTest classTrait',
	#instVars : [
		'activeObject'
	],
	#category : #'Concurrency-Test'
}

{ #category : #testing }
ActiveObjectTest >> activeObjProcess [
	activeObject ifNil: [ ^nil ].
	^activeObject instVarNamed: #process
]

{ #category : #testing }
ActiveObjectTest >> tearDown [
	super tearDown.
	self activeObjProcess ifNotNil: [ :process | process terminate ]
]
