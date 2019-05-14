Class {
	#name : #ZSubjectDemo,
	#superclass : #Object,
	#traits : 'LoTSubject',
	#classTraits : 'LoTSubject classTrait',
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Kernel'
}

{ #category : #accessing }
ZSubjectDemo >> dispatcher [
	dispatcher ifNil: [dispatcher := LoEventDispatcher new].
	^dispatcher
]
