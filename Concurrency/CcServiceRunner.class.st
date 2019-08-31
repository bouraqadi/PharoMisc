Class {
	#name : #CcServiceRunner,
	#superclass : #Object,
	#instVars : [
		'process',
		'serviceWeakArray',
		'postStopActionBlock'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #accessing }
CcServiceRunner >> activityBlock [
	^self service activityBlock
]

{ #category : #running }
CcServiceRunner >> doPostStopAction [
	postStopActionBlock ifNil: [ ^self ].
	postStopActionBlock value
]

{ #category : #initialization }
CcServiceRunner >> initialize [
	super initialize .
	serviceWeakArray := WeakArray new: 1
]

{ #category : #accessing }
CcServiceRunner >> name [
	^self service name
]

{ #category : #running }
CcServiceRunner >> newProcess [
	^[self activityBlock ensure: [ self doPostStopAction ]] newProcess
]

{ #category : #accessing }
CcServiceRunner >> priority [
	^self service priority
]

{ #category : #accessing }
CcServiceRunner >> process [
	^ process
]

{ #category : #accessing }
CcServiceRunner >> service [
	^serviceWeakArray first
]

{ #category : #accessing }
CcServiceRunner >> service: aService [
	^serviceWeakArray at: 1 put: aService
]

{ #category : #running }
CcServiceRunner >> start [
	process := self newProcess.
	process name: self name.
	process priority: self priority.
	process resume.

]

{ #category : #running }
CcServiceRunner >> stop [
	process ifNil: [ ^self ].
	process terminate

]

{ #category : #running }
CcServiceRunner >> stopThenDo: aBlock [
	process ifNil: [ ^aBlock value ].
	postStopActionBlock := aBlock.
	process terminate
]
