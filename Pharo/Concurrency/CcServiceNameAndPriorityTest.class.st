Class {
	#name : #CcServiceNameAndPriorityTest,
	#superclass : #CcServiceTest,
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcServiceNameAndPriorityTest >> testNameChangeWhileStarted [
	service := CcService do: [ [ 50 milliSeconds wait] repeat ].
	self startService.
	service name: 'Service for test only'.
	self assert: self serviceProcess name equals: service name.
	
]

{ #category : #testing }
CcServiceNameAndPriorityTest >> testNameChangeWhileStopped [
	service := CcService do: [ [ 50 milliSeconds wait] repeat ].
	service name: 'Service for test only'.
	self startService.
	self assert: self serviceProcess name equals: service name.
	
]

{ #category : #testing }
CcServiceNameAndPriorityTest >> testPriorityChangeWhileStarted [
	| initialPriority newPriority |
	initialPriority := Processor highestPriority.
	service := CcService do: [
			[(Delay forMilliseconds: 100) wait] repeat
	].
	service priority: initialPriority.
	self startService.
	newPriority := Processor userBackgroundPriority.
	self deny: newPriority = initialPriority.
	self assert: service isStarted.
	service priority: newPriority.
	self assert: self serviceProcess priority = newPriority

]

{ #category : #testing }
CcServiceNameAndPriorityTest >> testPriorityChangeWhileStopped [
	| initialPriority |
	initialPriority := Processor highestPriority.
	service := CcService do: [
			[(Delay forMilliseconds: 100) wait]repeat
			].
	self assert: service isStopped.
	service priority: initialPriority.
	self startService.
	self assert: self serviceProcess priority = initialPriority 
]
