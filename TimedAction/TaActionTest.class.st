Class {
	#name : #TaActionTest,
	#superclass : #TestCase,
	#instVars : [
		'createdActions'
	],
	#category : #TimedAction
}

{ #category : #testing }
TaActionTest >> after: aDuration do: aBlock [
	^self newActionFrom: (TaAction after: aDuration do: aBlock).

]

{ #category : #testing }
TaActionTest >> assertWaitUntil: aBlock [
	self assertWaitUntil: aBlock timeout: 300 milliSeconds
]

{ #category : #testing }
TaActionTest >> assertWaitUntil: aBlock timeout: duration [
	| deadline |
	deadline := DateAndTime now + duration.
	aBlock whileFalse: [ 
		DateAndTime now < deadline ifFalse: [ ^self fail: 'assertWait timeout!' ].
		100 milliSeconds wait.
	]
]

{ #category : #testing }
TaActionTest >> fireActionsDueOn: aDateAndTime [
	createdActions do: [ : action | action fireIfDueOn: aDateAndTime].
		

]

{ #category : #testing }
TaActionTest >> newActionFrom: anAction [
	createdActions add: anAction.
	^anAction
]

{ #category : #testing }
TaActionTest >> on: aDateAndTime do: aBlock [
	^self newActionFrom: (TaAction on: aDateAndTime do: aBlock).

]

{ #category : #testing }
TaActionTest >> on: aDateAndTime repeat: aBlock every: aDuration [
	^self newActionFrom: (TaAction on: aDateAndTime repeat: aBlock every: aDuration)
]

{ #category : #testing }
TaActionTest >> on: aDateAndTime repeat: aBlock every: aDuration stopAfter: lastDateAndTime [
	^self newActionFrom: (TaAction on: aDateAndTime repeat: aBlock every: aDuration stopAfter: lastDateAndTime)
]

{ #category : #testing }
TaActionTest >> on: aDateAndTime repeat: aBlock every: aDuration times: recurrenceCount [
	^self newActionFrom: (TaAction on: aDateAndTime repeat: aBlock every: aDuration times: recurrenceCount)
]

{ #category : #testing }
TaActionTest >> setUp [
	super setUp.
	createdActions := Set new.
]

{ #category : #testing }
TaActionTest >> tearDown [
	super tearDown.
	createdActions ifEmpty: [ ^self ].
	createdActions do: [: each | each stop].
]

{ #category : #testing }
TaActionTest >> testActionFiringLate [
	| actionInstant actionDone |
	actionInstant := DateAndTime tomorrow + Time noon.
	actionDone := false.
	self on: actionInstant do: [actionDone := true].
	self deny: actionDone.
	self fireActionsDueOn: actionInstant + 1 second.
	self assert: actionDone.
		

]

{ #category : #testing }
TaActionTest >> testActionFiringOnTime [
	| actionInstant actionDone |
	actionInstant := DateAndTime tomorrow + Time noon.
	actionDone := false.
	self on: actionInstant do: [actionDone := true].
	self deny: actionDone.
	self fireActionsDueOn: actionInstant - 1 second.
	self deny: actionDone.
	self fireActionsDueOn: actionInstant.
	self assert: actionDone.
		

]

{ #category : #testing }
TaActionTest >> testActionStopsAfterFiring [
	| newAction actionInstant |
	actionInstant := DateAndTime tomorrow + Time noon.
	newAction := self on: actionInstant do: [].
	self assert: newAction isStopped.
	newAction start.
	self deny: newAction isStopped.
	newAction fireIfDueOn: actionInstant.
	self assert: newAction isStopped.

		

]

{ #category : #testing }
TaActionTest >> testFiniteCountActionAutomaticallyFiresAndStops [
	| newAction actionCount |
	actionCount := 0.
	newAction := self on: DateAndTime now repeat: [actionCount := actionCount + 1] every: 1 milliSecond times: 3.
	newAction start.
	self assertWaitUntil: [actionCount = 3].
	self assert: newAction isStopped.

		

]

{ #category : #testing }
TaActionTest >> testFiniteDurationActionAutomaticallyFiresAndStops [
	| newAction actionCount |
	actionCount := 0.
	newAction := self on: DateAndTime now repeat: [actionCount := actionCount + 1] every: 1 milliSecond stopAfter: DateAndTime now + 100 milliSecond.
	newAction start.
	newAction isDueOn: DateAndTime now.
	self assertWaitUntil: [newAction isStopped].
	self deny: actionCount = 0.

		

]

{ #category : #testing }
TaActionTest >> testInfiniteRecurrentAction [
	| actionInstant actionPeriod actionFiringCount expectedFiringDateAndTime |
	actionInstant := DateAndTime tomorrow + Time noon.
	actionPeriod := 1 day.
	actionFiringCount := 0.
	self 
		on: actionInstant 
		repeat: [actionFiringCount := actionFiringCount + 1]
		every: actionPeriod.
	0 to: 10 do: [ : zeroOrMore |
			expectedFiringDateAndTime := actionInstant + (actionPeriod * zeroOrMore).
			self fireActionsDueOn: expectedFiringDateAndTime - 1 second.
			self assert: actionFiringCount equals: zeroOrMore.
			self fireActionsDueOn: expectedFiringDateAndTime.
			self assert: actionFiringCount equals: zeroOrMore + 1.
	]
		

]

{ #category : #testing }
TaActionTest >> testOneShotActionAutomaticallyFiresAfterSpecifiedDuration [
	| newAction actionDone |
	actionDone := false.
	newAction := self after: 1 milliSecond do: [actionDone := true].
	newAction start.
	self assertWaitUntil: [actionDone].
	self assert: newAction isStopped.

		

]

{ #category : #testing }
TaActionTest >> testOneShotActionAutomaticallyFiresAndStops [
	| newAction actionDone |
	actionDone := false.
	newAction := self on: DateAndTime now do: [actionDone := true].
	newAction start.
	self assertWaitUntil: [actionDone].
	self assert: newAction isStopped.

		

]

{ #category : #testing }
TaActionTest >> testRecurrentActionWithFiniteDuration [
	| firstInstant actionPeriod actionFiringCount  |
	firstInstant := DateAndTime tomorrow + Time noon.
	actionPeriod := 1 day.
	actionFiringCount := 0.
	self 
		on: firstInstant 
		repeat: [actionFiringCount := actionFiringCount + 1]
		every: actionPeriod
		stopAfter: firstInstant + 2 days + 1 hour.
	0 to: 2 do: [ : zeroOrMore | 
			self fireActionsDueOn: firstInstant + (actionPeriod * zeroOrMore).
			self assert: actionFiringCount equals: zeroOrMore + 1.
	].
			self assert: actionFiringCount equals: 3.
			self fireActionsDueOn: firstInstant + (actionPeriod * 3) + 1 second.
			self assert: actionFiringCount equals: 3.
		

]

{ #category : #testing }
TaActionTest >> testRecurrentActionWithFixedNumberOfRepetitions [
	| firstInstant actionPeriod actionFiringCount |
	firstInstant := DateAndTime tomorrow + Time noon.
	actionPeriod := 1 day.
	actionFiringCount := 0.
	self
		on: firstInstant 
		repeat: [actionFiringCount := actionFiringCount + 1]
		every: actionPeriod
		times: 3.
	0 to: 2 do: [ : zeroOrMore |
			self fireActionsDueOn: firstInstant + (actionPeriod * zeroOrMore).
			self assert: actionFiringCount equals: zeroOrMore + 1.
	].
			self assert: actionFiringCount equals: 3.
			self fireActionsDueOn: firstInstant + (actionPeriod * 3) + 1 second.
			self assert: actionFiringCount equals: 3.
		

]

{ #category : #testing }
TaActionTest >> testTwoActionsFiringAtDifferentInstants [
	| action1Instant action2Instant action1Fired action2Fired |
	action1Instant := DateAndTime tomorrow + Time noon.
	action2Instant := action1Instant + 2 hours.
	action1Fired := false.
	action2Fired := false.
	self on: action1Instant do: [action1Fired := true].
	self on: action2Instant do: [action2Fired := true].
	self fireActionsDueOn: action1Instant.
	self assert: action1Fired.
	self deny: action2Fired.
	self fireActionsDueOn: action2Instant.
	self assert: action2Fired.
		

]

{ #category : #testing }
TaActionTest >> testTwoActionsFiringAtTheSameInstant [
	| actionInstant action1Fired action2Fired |
	actionInstant := DateAndTime tomorrow + Time noon.
	action1Fired := false.
	action2Fired := false.
	self on: actionInstant do: [action1Fired := true].
	self on: actionInstant do: [action2Fired := true].
	self fireActionsDueOn: actionInstant.
	self assert: action1Fired.
	self assert: action2Fired.
		

]

{ #category : #testing }
TaActionTest >> testTwoActionsFirstToFireAddedLast [
	| action1Instant action2Instant action1 action2 |
	action1Instant := DateAndTime now.
	action2Instant := action1Instant + 2 hours.
	action2 := self on: action2Instant do: [].
	action2 start.
	action1 := self on: action1Instant do: [].
	action1 start.
	self fireActionsDueOn: action1Instant.
	self assert: action1 isStopped.
	self deny: action2 isStopped.
	self fireActionsDueOn: action2Instant.
	self assert: action2 isStopped.
		

]
