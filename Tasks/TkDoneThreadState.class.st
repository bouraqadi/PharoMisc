Class {
	#name : #TkDoneThreadState,
	#superclass : #TkThreadState,
	#instVars : [
		'observers'
	],
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #'initialize-release' }
TkDoneThreadState >> addObserver: aBlock [
	observers addLast: aBlock
]

{ #category : #stepping }
TkDoneThreadState >> enable [
	super enable.
	observers do: [ : each | each value ]
]

{ #category : #'initialize-release' }
TkDoneThreadState >> initialize [
	super initialize.
	observers := OrderedCollection new
]

{ #category : #testing }
TkDoneThreadState >> isDone [
	^true
]

{ #category : #'initialize-release' }
TkDoneThreadState >> removeObserver: aBlock [
	observers remove: aBlock ifAbsent: nil
]
