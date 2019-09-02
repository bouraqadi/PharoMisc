Class {
	#name : #CcServiceState,
	#superclass : #Object,
	#instVars : [
		'serviceWeakArray'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #accessing }
CcServiceState >> currentState: aState [
	self service state: aState
]

{ #category : #testing }
CcServiceState >> ifStarted: blockForStarted ifStopped: blockForStopped [ 
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

]

{ #category : #signalling }
CcServiceState >> signalProcessStarted [
	self service signalProcessStarted
	
]

{ #category : #signalling }
CcServiceState >> signalProcessStopped [
	self service signalProcessStopped
	
]

{ #category : #activity }
CcServiceState >> start [
	self subclassResponsibility
]

{ #category : #printing }
CcServiceState >> stateString [
	self subclassResponsibility
]

{ #category : #activity }
CcServiceState >> stop [
	self subclassResponsibility
]

{ #category : #state }
CcServiceState >> transitionTo: aStateClass [
	self currentState: aStateClass new
]

{ #category : #signalling }
CcServiceState >> waitProcessStarted [
	self service waitProcessStarted
	
]

{ #category : #signalling }
CcServiceState >> waitProcessStopped [
	self service waitProcessStopped
	
]
