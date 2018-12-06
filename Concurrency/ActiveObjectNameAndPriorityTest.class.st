Class {
	#name : #ActiveObjectNameAndPriorityTest,
	#superclass : #ActiveObjectTest,
	#category : #'Concurrency-Test'
}

{ #category : #testing }
ActiveObjectNameAndPriorityTest >> testNameChangeWhileStarted [
	activeObject := ActiveObject do: [ [ 50 milliSeconds wait] repeat ].
	activeObject start.
	activeObject name: 'active object for test only'.
	self assert: self activeObjProcess name equals: activeObject name.
	
]

{ #category : #testing }
ActiveObjectNameAndPriorityTest >> testNameChangeWhileStopped [
	activeObject := ActiveObject do: [ [ 50 milliSeconds wait] repeat ].
	activeObject name: 'active object for test only'.
	activeObject start.
	self assert: self activeObjProcess name equals: activeObject name.
	
]

{ #category : #testing }
ActiveObjectNameAndPriorityTest >> testPriorityChangeWhileStarted [
	| initialPriority newPriority |
	initialPriority := Processor highestPriority.
	activeObject := ActiveObject do: [
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
ActiveObjectNameAndPriorityTest >> testPriorityChangeWhileStopped [
	| initialPriority |
	initialPriority := Processor highestPriority.
	activeObject := ActiveObject do: [
			[(Delay forMilliseconds: 100) wait]repeat
			].
	self assert: activeObject isStopped.
	activeObject 
		priority: initialPriority;
		start.
	self assert: self activeObjProcess priority = initialPriority 
]
