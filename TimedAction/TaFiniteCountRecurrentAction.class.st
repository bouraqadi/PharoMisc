"
I represent a recurrent action that stops once fires a given number of times.

    Instance Variables
	recurrencesLeft:		<Integer> Number of reccurences lefts before stopping. 0 = stop now.

"
Class {
	#name : #TaFiniteCountRecurrentAction,
	#superclass : #TaFiniteRecurrentAction,
	#instVars : [
		'recurrencesLeft'
	],
	#category : #TimedAction
}

{ #category : #'instance creation' }
TaFiniteCountRecurrentAction class >> fireInstant: aDateAndTime actionBlock: aBlockClosure period: aDuration times: anInteger [ 
	^(self fireInstant: aDateAndTime actionBlock: aBlockClosure period: aDuration)
		recurrencesLeft: anInteger;
		yourself.
]

{ #category : #firing }
TaFiniteCountRecurrentAction >> cleanUp [
	super cleanUp.
	self recurrencesLeft: self recurrencesLeft - 1.

]

{ #category : #firing }
TaFiniteCountRecurrentAction >> isEndConditionMet [
	^self recurrencesLeft = 0

]

{ #category : #accessing }
TaFiniteCountRecurrentAction >> recurrencesLeft [
	^ recurrencesLeft
]

{ #category : #accessing }
TaFiniteCountRecurrentAction >> recurrencesLeft: anObject [
	recurrencesLeft := anObject
]
