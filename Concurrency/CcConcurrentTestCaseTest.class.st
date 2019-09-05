Class {
	#name : #CcConcurrentTestCaseTest,
	#superclass : #TestCase,
	#traits : 'CcTConcurrencyTest',
	#classTraits : 'CcTConcurrencyTest classTrait',
	#category : #'Concurrency-Test'
}

{ #category : #tests }
CcConcurrentTestCaseTest >> testInfiniteLoop [
	| timeOutDuration |
	timeOutDuration := 500 milliSeconds.
	self timeLimit: timeOutDuration.
	self 
		assertFork: [[100 milliSeconds wait] repeat] 
		raise: TestTookTooMuchTime 
		withinMilliseconds: timeOutDuration asMilliSeconds

]

{ #category : #tests }
CcConcurrentTestCaseTest >> testSemaphoreWaitForever [
	self should: [Semaphore new wait] raise: TestTookTooMuchTime.
]
