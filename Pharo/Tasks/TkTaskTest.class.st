Class {
	#name : #TkTaskTest,
	#superclass : #TestCase,
	#instVars : [
		'bench',
		'task'
	],
	#category : #'Tasks-Tests'
}

{ #category : #testing }
TkTaskTest class >> isAbstract [
	^self == TkTaskTest
]

{ #category : #tests }
TkTaskTest >> setUp [
	super setUp.
	bench := TkTaskTestBench new
]
