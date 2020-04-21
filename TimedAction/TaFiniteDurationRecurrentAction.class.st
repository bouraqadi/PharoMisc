"
I represent a recurrent action that stops once fires until a given instant inclusive.

Instance Variables
	lastFireInstant:		<DateAndTime> I stop firing with the current instant > lastFireInstant

"
Class {
	#name : #TaFiniteDurationRecurrentAction,
	#superclass : #TaFiniteRecurrentAction,
	#instVars : [
		'lastFireInstant'
	],
	#category : #TimedAction
}

{ #category : #'instance creation' }
TaFiniteDurationRecurrentAction class >> fireInstant: firstDateAndTime actionBlock: aBlockClosure period: aDuration stopAfter: lastDateAndTime [ 
	^(self fireInstant: firstDateAndTime actionBlock: aBlockClosure period: aDuration)
		lastFireInstant: lastDateAndTime;
		yourself.
]

{ #category : #firing }
TaFiniteDurationRecurrentAction >> isEndConditionMet [
	^self fireInstant  > self lastFireInstant
]

{ #category : #accessing }
TaFiniteDurationRecurrentAction >> lastFireInstant [
	^ lastFireInstant
]

{ #category : #accessing }
TaFiniteDurationRecurrentAction >> lastFireInstant: anObject [
	lastFireInstant := anObject
]
