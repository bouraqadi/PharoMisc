"
I represent an event that is triggered by a subject and dispatched to observers. 

Events are organized in a class hierarchy. Observers of an event class also observe its subclasses. 

See LoEvent class>>#dispatch:toObserversFrom:

"
Class {
	#name : #LoEvent,
	#superclass : #Object,
	#category : #'LightweightObserver-Kernel'
}

{ #category : #dispatching }
LoEvent class >> dispatch: anEvent toObserversFrom: aDispatcher [
	(aDispatcher observersOf: self) do: [: anObserver | anObserver handle: anEvent].		
	self == LoEvent ifTrue: [ ^self ].
	self superclass dispatch: anEvent toObserversFrom: aDispatcher

]

{ #category : #dispatching }
LoEvent >> dispatchToObserversFrom: aDispatcher [
	self class dispatch: self toObserversFrom: aDispatcher
]
