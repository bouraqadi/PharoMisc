Class {
	#name : #CcServiceNameAndPriorityTest,
	#superclass : #CcServiceTest,
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcServiceNameAndPriorityTest >> testNameChangeWhileStarted [
	service := CcService do: [ [ 50 milliSeconds wait] repeat ].
	service start.
	service name: 'active object for test only'.
	self assert: self activeObjProcess name equals: service name.
	
]

{ #category : #testing }
CcServiceNameAndPriorityTest >> testNameChangeWhileStopped [
	service := CcService do: [ [ 50 milliSeconds wait] repeat ].
	service name: 'active object for test only'.
	service start.
	self assert: self activeObjProcess name equals: service name.
	
]

{ #category : #testing }
CcServiceNameAndPriorityTest >> testPriorityChangeWhileStarted [
	| initialPriority newPriority |
	initialPriority := Processor highestPriority.
	service := CcService do: [
			[(Delay forMilliseconds: 100) wait] repeat
	].
	service 
		priority: initialPriority;
		start.
	newPriority := Processor userBackgroundPriority.
	self deny: newPriority = initialPriority.
	self assert: service isStarted.
	service priority: newPriority.
	self assert: self activeObjProcess priority = newPriority

]

{ #category : #testing }
CcServiceNameAndPriorityTest >> testPriorityChangeWhileStopped [
	| initialPriority |
	initialPriority := Processor highestPriority.
	service := CcService do: [
			[(Delay forMilliseconds: 100) wait]repeat
			].
	self assert: service isStopped.
	service 
		priority: initialPriority;
		start.
	self assert: self activeObjProcess priority = initialPriority 
]
