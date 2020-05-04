Class {
	#name : #TkFiniteDurationTask,
	#superclass : #TkFiniteTask,
	#instVars : [
		'duration',
		'endTime'
	],
	#category : #'Tasks-Kernel-Tasks'
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

{ #category : #initialization }
TkFiniteDurationTask >> initEndTime [
	self endTime: self now + self duration	
]

{ #category : #initialization }
TkFiniteDurationTask >> initialize [
	super initialize.
	pendingState addExitAction: [ self initEndTime ]
]

{ #category : #accessing }
TkFiniteDurationTask >> isEndConditionMet [
	self endTime ifNil: [ ^false ].
	^self now >= self endTime
]
