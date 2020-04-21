"
I represent an action that repeats over time.

Instance Variables
	period:		<Duration> Amount of time to wait between 2 firing
"
Class {
	#name : #TaRecurrentAction,
	#superclass : #TaAction,
	#instVars : [
		'period'
	],
	#category : #TimedAction
}

{ #category : #'instance creation' }
TaRecurrentAction class >> fireInstant: aDateAndTime actionBlock: aBlock period: aDuration [
	^(self fireInstant: aDateAndTime actionBlock: aBlock)
		period: aDuration;
		yourself
]

{ #category : #firing }
TaRecurrentAction >> cleanUp [
	self fireInstant: self fireInstant + self period.
]

{ #category : #firing }
TaRecurrentAction >> fire [
	super fire.
	self cleanUp.
]

{ #category : #accessing }
TaRecurrentAction >> period [
	^ period
]

{ #category : #accessing }
TaRecurrentAction >> period: anObject [
	period := anObject
]
