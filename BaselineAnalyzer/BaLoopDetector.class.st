"
I analyze a baseline and detect if they are loops in declared dependencies.

Example
analyzer := BaLoopDetector analyzeBaselineClass:  BaselineOfPlcWeb.
analyzer dependencyLoops size.
analyzer shortestLoop. ""Handy because smaller loops appear also in larger ones""
"
Class {
	#name : #BaLoopDetector,
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
BaLoopDetector class >> analyzeBaselineClass: aClass [

	^ self new
		  analyzeBaselineClass: aClass new;
		  yourself
]

{ #category : #'navigating baseline' }
BaLoopDetector >> analyzeBaseline: aBaseline [

	self resetPackagesDict.
	aBaseline baseline: self.
	self startAnalyzing
]

{ #category : #'navigating baseline' }
BaLoopDetector >> analyzeBaselineClass: aBaselineClass [

	self analyzeBaseline: aBaselineClass.

]

{ #category : #'navigating baseline' }
BaLoopDetector >> baseline: project with: aBlock [

	aBlock value
]

{ #category : #analyzing }
BaLoopDetector >> dependencyLoops [

	^ dependencyLoops
]

{ #category : #analyzing }
BaLoopDetector >> explore: package [

	| isLoopDetected |
	isLoopDetected := currentPath includes: package.
	currentPath addLast: package.
	self exploreAllPackagesFrom: package ifNoLoop: isLoopDetected.
	currentPath remove: package
]

{ #category : #analyzing }
BaLoopDetector >> exploreAllPackagesFrom: package ifNoLoop: isLoopDetected [

	| nextPackages |
	isLoopDetected ifTrue: [ ^ dependencyLoops add: currentPath asArray ].
	nextPackages := self packageDependencyCollectionAt: package.
	nextPackages do: [ :each | self explore: each ]
]

{ #category : #analyzing }
BaLoopDetector >> exploreStartingAt: package [
	currentPath := OrderedCollection new.
	self explore: package
	
]

{ #category : #'navigating baseline' }
BaLoopDetector >> for: aSymbol do: aBlock [
	aBlock value
]

{ #category : #'navigating baseline' }
BaLoopDetector >> group: groupName with: aBlock [

	^self
]

{ #category : #'navigating baseline' }
BaLoopDetector >> package: packageName [
	self package: packageName with: nil

]

{ #category : #'navigating baseline' }
BaLoopDetector >> package: packageName with: aBlock [

	currentDependencyCollection := self packageDependencyCollectionAt: packageName.
	aBlock value
]

{ #category : #'navigating baseline' }
BaLoopDetector >> packageDependencyCollectionAt: packageName [

	^ packagesDict at: packageName ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #accessing }
BaLoopDetector >> packagesDict [

	^ packagesDict
]

{ #category : #initialization }
BaLoopDetector >> packagesDict: anObject [

	packagesDict := anObject
]

{ #category : #'navigating baseline' }
BaLoopDetector >> repository: repo [
	^self
]

{ #category : #'navigating baseline' }
BaLoopDetector >> requires: aCollection [

	aCollection do: [: each |
		currentDependencyCollection add: each asSymbol]
]

{ #category : #initialization }
BaLoopDetector >> resetPackagesDict [

	self packagesDict: Dictionary new
]

{ #category : #analyzing }
BaLoopDetector >> shortestLoop [

	self dependencyLoops ifEmpty: [ ^ #(  ) ].
	^ self dependencyLoops first
]

{ #category : #analyzing }
BaLoopDetector >> startAnalyzing [

	dependencyLoops := SortedCollection sortBlock: [: a : b | a size < b size].
	packagesDict keysDo: [ :each | self exploreStartingAt: each ]
]
