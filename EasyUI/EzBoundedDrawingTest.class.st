Class {
	#name : #EzBoundedDrawingTest,
	#superclass : #TestCase,
	#instVars : [
		'drawing'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #tests }
EzBoundedDrawingTest >> setUp [

	super setUp.
	drawing := EzOval circleCenter: 0 @ 0 radius: 80
]

{ #category : #tests }
EzBoundedDrawingTest >> testExtentAlwaysInt [

	{ (0.1 -> 1).
		(0.8 -> 1).
		(3.14 -> 3) } asDictionary keysAndValuesDo: [ :provided :expected | 
		drawing width: provided.
		self assert: drawing width equals: expected.
		drawing height: provided.
		self assert: drawing height equals: expected.
		drawing width: provided height: provided.
		self assert: drawing width equals: expected.
		self assert: drawing height equals: expected ]
]

{ #category : #tests }
EzBoundedDrawingTest >> testExtentAlwaysPositive [

	#( 0 -1 -974 ) do: [ :invalidValue | 
		drawing width: 100 height: 100.
self assert: drawing width equals: 100.
		self assert: drawing height equals: 100.
		drawing width: invalidValue.
		self assert: drawing width equals: 1.
		drawing height: invalidValue.
		self assert: drawing height equals: 1.
		drawing width: 100 height: 100.
		drawing width: invalidValue height: invalidValue.
		self assert: drawing width equals: 1.
		self assert: drawing height equals: 1.
		drawing width: 100 height: 100.
		drawing width: 42 height: invalidValue.
		self assert: drawing width equals: 42.
		self assert: drawing height equals: 1.
		drawing width: 100 height: 100.
		drawing width: invalidValue height: 56.
		self assert: drawing width equals: 1.
		self assert: drawing height equals: 56 ]
]
