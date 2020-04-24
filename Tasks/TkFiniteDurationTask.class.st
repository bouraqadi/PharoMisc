Class {
	#name : #TkFiniteDurationTask,
	#superclass : #TkFiniteTask,
	#instVars : [
		'duration',
		'endTime'
	],
	#category : #'Tasks-Kernel'
}

{ #category : #accessing }
TkFiniteDurationTask >> duration [
	^ duration
]

{ #category : #accessing }
TkFiniteDurationTask >> duration: aDuration [
	duration := aDuration
]

{ #category : #accessing }
TkFiniteDurationTask >> endTime [
	^ endTime
]

{ #category : #accessing }
TkFiniteDurationTask >> endTime: aDateAndTime [
	endTime := aDateAndTime
]

{ #category : #accessing }
TkFiniteDurationTask >> isEndConditionMet [
	self endTime ifNil: [ ^false ].
	^self now >= self endTime
]

{ #category : #acting }
TkFiniteDurationTask >> valueActionBlock [
	super valueActionBlock.
	self endTime: self now + self duration	
]
