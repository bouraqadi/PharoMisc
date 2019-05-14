"
I am a subject that can have many observers. I automatically generate events  for IV assignments. Observers can subscribe to those events using mehtods :
- afterChangeOf: ivName do: aBlock
aBlock is valued after executing a method that assigns a new value to the referenced IV.
aBlock can have 0 or 1 argument which is the last value of the changed IV.

- afterChangeDo: aBlock
aBlock is valued after executing a method that performs assignments to one or more IVs.
aBlock can have 0 or 1 argument which is the event materializing the change.
Changed IVs and their last values are stored in the event (see LoIvChangeEvent).
 
Each of the above methods ansewers an object that is the observer. It can be used to unsbscribe from the subject and stop observing.

    Instance Variables
	dispatcher:		<LoEventDispatcher>


    Implementation Points
Every method with at least one IV assignment is saved in the method dictionary under a selector prefixed with basicSubjectMethod_. Another method using the original selector is generated to call the ""basic"" method and generate the event.
"
Class {
	#name : #LoSubject,
	#superclass : #Object,
	#traits : 'LoTSubject',
	#classTraits : 'LoTSubject classTrait',
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Kernel'
}

{ #category : #accessing }
LoSubject >> dispatcher [
	dispatcher ifNil: [dispatcher := LoEventDispatcher new].
	^dispatcher
]
