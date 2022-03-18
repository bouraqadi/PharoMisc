Class {
	#name : #BaLoopDetectorTest,
	#superclass : #TestCase,
	#instVars : [
		'analyzer'
	],
	#category : #BaselineAnalyzer
}

{ #category : #tests }
BaLoopDetectorTest >> packagesDict: associations [

	analyzer packagesDict: associations asDictionary.
	analyzer startAnalyzing 

]

{ #category : #tests }
BaLoopDetectorTest >> setUp [
	super setUp.
	analyzer := BaLoopDetector new.
]

{ #category : #tests }
BaLoopDetectorTest >> test0Loop [

	self packagesDict: { 
			('a' -> #( b c )).
			('b' -> #( c )).
			('c' -> #(  )) }.
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaLoopDetectorTest >> test1StepLoop [

	self packagesDict: { 
			('a' -> #( b c )).
			('b' -> #( c a )).
			('c' -> #(  )) }.
	self assertCollection: analyzer dependencyLoops hasSameElements: { 
			#( a b a ).
			#( b a b ) }
]

{ #category : #tests }
BaLoopDetectorTest >> test2StepsLoop [

	self packagesDict: { 
			('a' -> #( b )).
			('b' -> #( c )).
			('c' -> #( a )) }.
	self assertCollection: analyzer dependencyLoops hasSameElements: { 
			#( a b c a ).
			#( b c a b ).
			#( c a b c ) }
]

{ #category : #tests }
BaLoopDetectorTest >> testExternalDependencies [

	self packagesDict: { 
			('a' -> #( w z b )).
			('b' -> #( c x )).
			('c' -> #( y )) }.
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaLoopDetectorTest >> testNoDependencies [

	self packagesDict: { 
			('a' -> #(  )).
			('b' -> #(  )).
			('c' -> #(  )) }.
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaLoopDetectorTest >> testNoPackages [

	self packagesDict: #(  ).
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaLoopDetectorTest >> testSelfDependency [

	self packagesDict: { 
			('a' -> #( w z a y )).
			('b' -> #( b )).
			('c' -> #( c )) }.
	self assertCollection: analyzer dependencyLoops hasSameElements: { 
			#( a a ).
			#( b b ).
			#( c c ) }
]

{ #category : #tests }
BaLoopDetectorTest >> testShortest1StepLoop [

	| validResponses |
	self packagesDict: { 
			('a' -> #( b )).
			('b' -> #( a )).
			('c' -> #( a )).
			( #d -> #( c ) ) }.
	validResponses := { 
		                  #( a b a ).
		                  #( b a b ) }.
	self assert: (validResponses includes: analyzer shortestLoop)
]

{ #category : #tests }
BaLoopDetectorTest >> testShortestNoLoop [

	self packagesDict: { 
			('a' -> #( b )).
			('b' -> #(  )).
			('c' -> #( b )) }.
	self assert: analyzer shortestLoop equals: #(  )
]
