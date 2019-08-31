Class {
	#name : #CcServiceRunner,
	#superclass : #Object,
	#instVars : [
		'process',
		'serviceWeakArray'
	],
	#category : #'Concurrency-Kernel'
}

{ #category : #accessing }
CcServiceRunner >> activityBlock [
	^self service activityBlock
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
	^[self activityBlock ensure: [ self stopService ]] newProcess
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
CcServiceRunner >> start: aService [
	self service: aService.
	process := self newProcess.
	process name: aService name.
	process priority: aService priority.
	process resume.

]

{ #category : #running }
CcServiceRunner >> stop [
	process ifNil: [ ^self ].
	process terminate

]

{ #category : #running }
CcServiceRunner >> stopService [
	| service |
	service := self service ifNil: [ ^nil ].
	service stop
]
