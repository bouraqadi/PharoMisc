Class {
	#name : #TkFiniteDurationTask,
	#superclass : #TkFiniteTask,
	#instVars : [
		'duration',
		'endTime'
	],
	#category : #Tasks
}

{ #category : #accessing }
TkFiniteDurationTask >> duration [
	^ duration
]

{ #category : #accessing }
TkFiniteDurationTask >> duration: anObject [
	duration := anObject
]

{ #category : #accessing }
TkFiniteDurationTask >> endTime [
	^ endTime
]

{ #category : #accessing }
TkFiniteDurationTask >> endTime: anObject [
	endTime := anObject
]

{ #category : #initialization }
TkFiniteDurationTask >> initialize [
	super initialize.
	self endConditionBlock: [ self now > self endTime ]
]

{ #category : #accessing }
TkFiniteDurationTask >> isEndConditionMet [
	self endTime ifNil: [ ^false ].
	^super isEndConditionMet
]

{ #category : #accessing }
TkFiniteDurationTask >> now [
	^DateAndTime now
]

{ #category : #initialization }
TkFiniteDurationTask >> reset [
	super reset.
	self endTime: nil
]

{ #category : #acting }
TkFiniteDurationTask >> setUp [
	super setUp.
	self endTime: self now + self duration
]
