Class {
	#name : #CcServiceState,
	#superclass : #Object,
	#instVars : [
		'serviceWeakArray'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #state }
CcServiceState >> doEnterAction [
	^self
]

{ #category : #state }
CcServiceState >> doExitAction [
	^self
]

{ #category : #testing }
CcServiceState >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
	self subclassResponsibility
]

{ #category : #testing }
CcServiceState >> isCurrentState [
	^self state == self
]

{ #category : #testing }
CcServiceState >> isStarted [
	self subclassResponsibility
]

{ #category : #testing }
CcServiceState >> isStopped [
	self subclassResponsibility
]

{ #category : #accessing }
CcServiceState >> process [
	^self service process
]

{ #category : #accessing }
CcServiceState >> runner [
	^self service runner
]

{ #category : #accessing }
CcServiceState >> service [
	^ serviceWeakArray first
]

{ #category : #accessing }
CcServiceState >> service: aService [
	serviceWeakArray := WeakArray with: aService.
	self doEnterAction
]

{ #category : #activity }
CcServiceState >> start [
	self subclassResponsibility
]

{ #category : #accessing }
CcServiceState >> state [
	^self service state
]

{ #category : #accessing }
CcServiceState >> state: aState [
	self doExitAction.
	self service state: aState.
]

{ #category : #activity }
CcServiceState >> stop [
	self subclassResponsibility
]

{ #category : #state }
CcServiceState >> transitionTo: aStateClass [
	self state: aStateClass new
]
