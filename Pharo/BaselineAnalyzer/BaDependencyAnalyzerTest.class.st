Class {
	#name : #BaDependencyAnalyzerTest,
	#superclass : #TestCase,
	#instVars : [
		'analyzer'
	],
	#category : #BaselineAnalyzer
}

{ #category : #tests }
BaDependencyAnalyzerTest >> packagesDict: associations [

	analyzer packagesDict: associations asDictionary.
	analyzer startAnalyzing 

]

{ #category : #tests }
BaDependencyAnalyzerTest >> setUp [
	super setUp.
	analyzer := BaDependencyAnalyzer new.
]

{ #category : #tests }
BaDependencyAnalyzerTest >> test0Loop [

	self packagesDict: { 
			('a' -> #( b c )).
			('b' -> #( c )).
			('c' -> #(  )) }.
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaDependencyAnalyzerTest >> test1Root [

	self packagesDict: { 
			('a' -> #( b c )).
			('b' -> #( c )).
			('c' -> #(  )) }.
	self assert: analyzer internalRoots equals: #( c ) asSet
]

{ #category : #tests }
BaDependencyAnalyzerTest >> test1StepLoop [

	self packagesDict: { 
			('a' -> #( b c )).
			('b' -> #( c a )).
			('c' -> #(  )) }.
	self assertCollection: analyzer dependencyLoops hasSameElements: { 
			#( a b a ).
			#( b a b ) }
]

{ #category : #tests }
BaDependencyAnalyzerTest >> test2Roots1ExternalIgnored [

	self packagesDict: { 
			(#a -> #( c d )).
			(#c -> #( d )) }.
	self assert: analyzer internalRoots equals: #( c ) asSet
]

{ #category : #tests }
BaDependencyAnalyzerTest >> test2Roots1PerChild [

	self packagesDict: { 
			(#a -> #( b c )).
			(#b -> #( d )).
			(#c -> #(  )).
			(#d -> #(  )) }.
	self assert: analyzer internalRoots equals: #( c d ) asSet
]

{ #category : #tests }
BaDependencyAnalyzerTest >> test2RootsSameChild [

	self packagesDict: { 
			(#a -> #( c d )).
			(#c -> #(  )).
			(#d -> #(  )) }.
	self assert: analyzer internalRoots equals: #( c d ) asSet
]

{ #category : #tests }
BaDependencyAnalyzerTest >> test2StepsLoop [

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
BaDependencyAnalyzerTest >> testExternalDependencies [

	self packagesDict: { 
			('a' -> #( w z b )).
			('b' -> #( c x )).
			('c' -> #( y )) }.
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaDependencyAnalyzerTest >> testNoDependencies [

	self packagesDict: { 
			('a' -> #(  )).
			('b' -> #(  )).
			('c' -> #(  )) }.
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaDependencyAnalyzerTest >> testNoPackages [

	self packagesDict: #(  ).
	self assert: analyzer dependencyLoops isEmpty
]

{ #category : #tests }
BaDependencyAnalyzerTest >> testRootsWithLoops [

	self packagesDict: { 
			(#a -> #( b c )).
			(#b -> #( c d )).
			(#c -> #( b)).
			(#d -> #( a )) }.
	self should: [analyzer internalRoots] raise: Exception
]

{ #category : #tests }
BaDependencyAnalyzerTest >> testSelfDependency [

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
BaDependencyAnalyzerTest >> testShortest1StepLoop [

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
BaDependencyAnalyzerTest >> testShortestNoLoop [

	self packagesDict: { 
			('a' -> #( b )).
			('b' -> #(  )).
			('c' -> #( b )) }.
	self assert: analyzer shortestLoop equals: #(  )
]
