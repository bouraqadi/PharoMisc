"
I am a generic single event observer. I perform a block when I am notified that an event instance of the event class I subscribed to occured.

I am typically created by the event dispatcher. 
See LoEventDispatcher>>#on:do:

Internal Representation and Key Implementation Points.

    Instance Variables
	actionBlock:		<BlockClosure>
	observersPool:		<Set>

    Implementation Points
I am observing while I am inside the observers pool.
Observation stops when I quit the pool.


"
Class {
	#name : #LoGenericObserver,
	#superclass : #Object,
	#instVars : [
		'observersPool',
		'actionBlock'
	],
	#category : #'LightweightObserver-Kernel'
}

{ #category : #'instance creation' }
LoGenericObserver class >> observersPool: eventObservers actionBlock: aBlockClosure [
	^self new
		observersPool: eventObservers;
		actionBlock: aBlockClosure;
		yourself
]

{ #category : #accessing }
LoGenericObserver >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
LoGenericObserver >> actionBlock: anObject [
	actionBlock := anObject
]

{ #category : #observing }
LoGenericObserver >> handle: anEvent [
	self actionBlock cull: anEvent
]

{ #category : #accessing }
LoGenericObserver >> observersPool [
	^ observersPool
]

{ #category : #accessing }
LoGenericObserver >> observersPool: aCollection [
	observersPool := aCollection.
	self startObserving
]

{ #category : #observing }
LoGenericObserver >> startObserving [
	 self observersPool add: self
]

{ #category : #observing }
LoGenericObserver >> stopObserving [
	 self observersPool remove: self ifAbsent:  []
]
