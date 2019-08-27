Class {
	#name : #CcThreadNameAndPriorityTest,
	#superclass : #CcThreadTest,
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcThreadNameAndPriorityTest >> testNameChangeWhileStarted [
	activeObject := CcThread do: [ [ 50 milliSeconds wait] repeat ].
	activeObject start.
	activeObject name: 'active object for test only'.
	self assert: self activeObjProcess name equals: activeObject name.
	
]

{ #category : #testing }
CcThreadNameAndPriorityTest >> testNameChangeWhileStopped [
	activeObject := CcThread do: [ [ 50 milliSeconds wait] repeat ].
	activeObject name: 'active object for test only'.
	activeObject start.
	self assert: self activeObjProcess name equals: activeObject name.
	
]

{ #category : #testing }
CcThreadNameAndPriorityTest >> testPriorityChangeWhileStarted [
	| initialPriority newPriority |
	initialPriority := Processor highestPriority.
	activeObject := CcThread do: [
			[(Delay forMilliseconds: 100) wait] repeat
	].
	activeObject 
		priority: initialPriority;
		start.
	newPriority := Processor userBackgroundPriority.
	self deny: newPriority = initialPriority.
	self assert: activeObject isStarted.
	activeObject priority: newPriority.
	self assert: self activeObjProcess priority = newPriority

]

{ #category : #testing }
CcThreadNameAndPriorityTest >> testPriorityChangeWhileStopped [
	| initialPriority |
	initialPriority := Processor highestPriority.
	activeObject := CcThread do: [
			[(Delay forMilliseconds: 100) wait]repeat
			].
	self assert: activeObject isStopped.
	activeObject 
		priority: initialPriority;
		start.
	self assert: self activeObjProcess priority = initialPriority 
]
