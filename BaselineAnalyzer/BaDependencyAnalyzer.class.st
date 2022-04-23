"
I analyze a baseline and detect if they are loops in declared dependencies.

Example
analyzer := BaDependencyAnalyzer analyzeBaselineClass:  BaselineOfPlcWeb.
analyzer dependencyLoops size.
analyzer shortestLoop. ""Handy because smaller loops might be included into larger ones""
analyzer internalRoots. ""Answers a set with dependency internal roots. Those are packages of the project that might depend only on extrnal packages. In case of loops, une exception is signaled.""
"
Class {
	#name : #BaDependencyAnalyzer,
	#superclass : #Object,
	#instVars : [
		'packagesDict',
		'dependencyLoops',
		'currentPath',
		'currentDependencyCollection'
	],
	#category : #BaselineAnalyzer
}

{ #category : #'instance creation' }
BaDependencyAnalyzer class >> analyzeBaselineClass: aClass [

	^ self new
		  analyzeBaselineClass: aClass;
		  yourself
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> analyzeBaseline: aBaseline [

	self reset.
	aBaseline baseline: self.
	self startAnalyzing
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> analyzeBaselineClass: aBaselineClass [

	self analyzeBaseline: aBaselineClass new
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> baseline: project with: aBlock [

	aBlock value
]

{ #category : #analyzing }
BaDependencyAnalyzer >> dependencyLoops [

	^ dependencyLoops
]

{ #category : #analyzing }
BaDependencyAnalyzer >> explore: package [

	| isLoopDetected |
	isLoopDetected := currentPath includes: package.
	currentPath addLast: package.
	self exploreAllPackagesFrom: package ifNoLoop: isLoopDetected.
	currentPath remove: package
]

{ #category : #analyzing }
BaDependencyAnalyzer >> exploreAllPackagesFrom: package ifNoLoop: isLoopDetected [

	| nextPackages |
	isLoopDetected ifTrue: [ ^ dependencyLoops add: currentPath asArray ].
	nextPackages := self packageDependencyCollectionAt: package.
	nextPackages do: [ :each | self explore: each ]
]

{ #category : #analyzing }
BaDependencyAnalyzer >> exploreStartingAt: package [
	currentPath := OrderedCollection new.
	self explore: package
	
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> for: aSymbol do: aBlock [
	aBlock value
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> group: groupName with: aBlock [

	^self
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> internalPackageDependencyCollectionAt: packageName [

	^ packagesDict
		  at: packageName asSymbol
		  ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #analyzing }
BaDependencyAnalyzer >> internalRoots [

	| roots internalPackages|
	self dependencyLoops ifNotEmpty: [ 
		self error: 'Loops detected in dependency graph' ].
	roots := Set new.
	internalPackages := self packagesDict keys.
	self packagesDict keysAndValuesDo: [ :package :dependencies | 
		(dependencies includesAnyOf: internalPackages) ifFalse: [ roots add: package ] ].
	^ roots
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> package: packageName [
	self package: packageName with: nil

]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> package: packageName with: aBlock [

	currentDependencyCollection := self internalPackageDependencyCollectionAt:
		                               packageName.
	aBlock value
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> packageDependencyCollectionAt: packageName [

	^ packagesDict
		  at: packageName asSymbol
		  ifAbsent: [ OrderedCollection new ]
]

{ #category : #accessing }
BaDependencyAnalyzer >> packagesDict [

	^ packagesDict
]

{ #category : #initialization }
BaDependencyAnalyzer >> packagesDict: aDictionary [

	packagesDict := aDictionary.
	dependencyLoops := SortedCollection sortBlock: [ :a :b | 
		                   a size < b size ].

]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> repository: repo [
	^self
]

{ #category : #'navigating baseline' }
BaDependencyAnalyzer >> requires: aCollection [

	aCollection do: [: each |
		currentDependencyCollection add: each asSymbol]
]

{ #category : #initialization }
BaDependencyAnalyzer >> reset [

	self packagesDict: Dictionary new.

]

{ #category : #analyzing }
BaDependencyAnalyzer >> shortestLoop [

	self dependencyLoops ifEmpty: [ ^ #(  ) ].
	^ self dependencyLoops first
]

{ #category : #analyzing }
BaDependencyAnalyzer >> startAnalyzing [

	packagesDict keysDo: [ :each | self exploreStartingAt: each ]
]
