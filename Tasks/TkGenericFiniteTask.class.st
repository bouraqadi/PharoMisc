Class {
	#name : #TkGenericFiniteTask,
	#superclass : #TkFiniteTask,
	#instVars : [
		'endConditionBlock'
	],
	#category : #'Tasks-Kernel'
}

{ #category : #accessing }
TkGenericFiniteTask >> endConditionBlock [
	^ endConditionBlock
]

{ #category : #accessing }
TkGenericFiniteTask >> endConditionBlock: aBlock [
	endConditionBlock := aBlock
]

{ #category : #testing }
TkGenericFiniteTask >> isEndConditionMet [
	^self endConditionBlock value
]
