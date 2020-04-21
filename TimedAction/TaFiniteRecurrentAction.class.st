"
I represent a recurrent action that automatically stops once some condition is true.

I am an abstract class. 
Subclasses should implement: 
-isEndConditionMet
Answers true when the stop condition is met
"
Class {
	#name : #TaFiniteRecurrentAction,
	#superclass : #TaRecurrentAction,
	#category : #TimedAction
}

{ #category : #firing }
TaFiniteRecurrentAction >> fire [
	super fire.
	self isEndConditionMet ifTrue: [ self stop].
]

{ #category : #firing }
TaFiniteRecurrentAction >> isDueOn: aDateAndTime [
	^(super isDueOn: aDateAndTime) 
			and: [self isEndConditionMet not]
]

{ #category : #firing }
TaFiniteRecurrentAction >> isEndConditionMet [
	self subclassResponsibility
]
