Class {
	#name : #CcServiceRacingConditions,
	#superclass : #CcServiceActivityTest,
	#category : #'Concurrency-Test'
}

{ #category : #testing }
CcServiceRacingConditions >> testConcurrentStartStop [
	| starter stopper switchForcing testSupportServices |
	service := CcService repeat: [] every: 300 milliSecond ensure: [
			activityTerminatedSemaphore signal
	].
	service priority: 40.
	starter := CcService repeat: [ service start ] every: 50 milliSeconds.
	stopper := CcService repeat: [ service stop] every: 50 milliSeconds.
	{starter. stopper} do: [ : each | each priority: 45 ].
	switchForcing := CcService repeat: ["Do Nothing!"] every: 30 milliSeconds.
	switchForcing priority: 50. 
	testSupportServices := {switchForcing. starter. stopper }.
	testSupportServices do: #start.
	500 milliSeconds wait.
	testSupportServices do: #stop.
]

{ #category : #testing }
CcServiceRacingConditions >> testFastStartStop [
	service := CcService repeat: [] every: 300 milliSecond ensure: [
			activityTerminatedSemaphore signal.
	].
	5 timesRepeat: [service start;stop; start;stop].
	self assertSemaphore: activityTerminatedSemaphore signaledWithinMilliseconds: 500.
]
