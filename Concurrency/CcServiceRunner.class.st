Class {
	#name : #CcServiceRunner,
	#superclass : #Object,
	#instVars : [
		'process',
		'ensureBlock',
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
	^ [ self run ] newProcess
]

{ #category : #running }
CcServiceRunner >> onProcessStarted [
	self service ifNil: [ ^self ].
	self service onProcessStarted
]

{ #category : #running }
CcServiceRunner >> onProcessStopped [
	ensureBlock value.
	self service ifNotNil: [: aService | aService onProcessStopped]

]

{ #category : #accessing }
CcServiceRunner >> priority [
	^self service priority
]

{ #category : #accessing }
CcServiceRunner >> process [
	^ process
]

{ #category : #running }
CcServiceRunner >> run [
	^ [ self onProcessStarted.
	self activityBlock value ]
		ensure: [ self onProcessStopped ]
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
	ensureBlock := self service ensureBlock.
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
