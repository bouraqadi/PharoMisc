"
I am a one shot action, that is an action that performs once then stops (i.e. become disabled)
"
Class {
	#name : #TaOneShotAction,
	#superclass : #TaAction,
	#category : #TimedAction
}

{ #category : #firing }
TaOneShotAction >> fire [
	super fire.
	self stop.
]
