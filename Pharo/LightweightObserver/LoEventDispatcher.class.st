"
I dispatch events, that is I perform blocks registered for given event classes.

    Instance Variables
	dispatchDict:		<Dictionary : EventClass -> (Set of BlockClosure)>


"
Class {
	#name : #LoEventDispatcher,
	#superclass : #Object,
	#instVars : [
		'dispatchDict'
	],
	#category : #'LightweightObserver-Kernel'
}

{ #category : #dispatching }
LoEventDispatcher >> dispatch: event [ 
	event dispatchToObserversFrom: self 

]

{ #category : #'initialize-release' }
LoEventDispatcher >> initialize [
	super initialize.
	dispatchDict := Dictionary new.

]

{ #category : #accessing }
LoEventDispatcher >> observersOf: eventClass [
	^dispatchDict at: eventClass ifAbsentPut: Set new
]

{ #category : #dispatching }
LoEventDispatcher >> on: eventClass do: aBlockClosure [ 
	| eventObservers |
	eventObservers := self observersOf: eventClass. 
	^LoGenericObserver observersPool: eventObservers actionBlock: aBlockClosure.
	
]

{ #category : #dispatching }
LoEventDispatcher >> unsubscribe: anObserver [
	anObserver stopObserving
]
