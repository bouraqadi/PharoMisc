Class {
	#name : #TkThreadFinalizer,
	#superclass : #Object,
	#instVars : [
		'thread'
	],
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #'instance creation' }
TkThreadFinalizer class >> thread: aThread [
	^self new
		thread: aThread;
		yourself
]

{ #category : #'reflective operations' }
TkThreadFinalizer >> doesNotUnderstand: aMessage [
	^aMessage sendTo: self thread
]

{ #category : #initialization }
TkThreadFinalizer >> finalize [
	self thread isFinalizationEnabled ifFalse: [ ^self ].
	self thread kill
]

{ #category : #accessing }
TkThreadFinalizer >> process [
	^self thread process
]

{ #category : #initialization }
TkThreadFinalizer >> registerForFinalization [
	self finalizationRegistry add: self
]

{ #category : #accessing }
TkThreadFinalizer >> thread [
	^thread
]

{ #category : #accessing }
TkThreadFinalizer >> thread: aThread [
	thread := aThread.
	self registerForFinalization
]
