"
I am a timed action, that is I have a block that I value at a given instant in time.

I am in charge of deciding of the moment to fire the block.
I manage a runner that keeps track of time and triggers me.
I create the runner, start it and stop it.

Public API and Key Messages
-start
Enable the action, so it will fire if it's time 
-stop
Disabled the action, so it will suspend, until the start message is sent again.

I am abastract. You should use my subclasses instead. However, I provide class side facility methods to create sub-instances depending on the kind of action to perform:
-on: aDateAndTime do: aBlock
Creates a one shot action, that is an action that automatically stops after firing once. Firing means valuing the block argument. This takes place once the current date and time is reaches the given instant (aDateAndTime).

-on: aDateAndTime repeat: aBlock every: aDuration  
Creates an action that infinitly fires. Two firings are separated by the aDuration.

-on: aDateAndTime repeat: aBlock every: aDuration stopAfter: lastDateAndTime
Creates an action that fires repeatedly until passing the lastDateAndTime

-on: aDateAndTime repeat: aBlock every: aDuration times: recurrenceCount
Creates an action that fires a given number of times.

    Instance Variables
	actionBlock:		<Block> Valued at every firing
	fireInstant:		<DateAndTime> The instant when the next firing will be triggered
	runner:		<TaActionRunner> In charge of executing the action and triggering it.

"
Class {
	#name : #TaAction,
	#superclass : #Object,
	#instVars : [
		'actionBlock',
		'fireInstant',
		'runner'
	],
	#category : #TimedAction
}

{ #category : #'started instance creation' }
TaAction class >> after: aDuration do: aBlock [
	^self on: self now + aDuration do: aBlock
]

{ #category : #'insance creation' }
TaAction class >> fireInstant: aDateAndTime actionBlock: aBlock [
	^self new
		fireInstant: aDateAndTime;
		actionBlock: aBlock;
		yourself
]

{ #category : #accessing }
TaAction class >> now [
	^DateAndTime now
]

{ #category : #'started instance creation' }
TaAction class >> on: aDateAndTime do: aBlock [
	^TaOneShotAction fireInstant: aDateAndTime actionBlock: aBlock.

]

{ #category : #'started instance creation' }
TaAction class >> on: aDateAndTime repeat: aBlock every: aDuration [ 
	^TaRecurrentAction fireInstant: aDateAndTime actionBlock: aBlock period: aDuration.
]

{ #category : #'started instance creation' }
TaAction class >> on: aDateAndTime repeat: aBlock every: aDuration stopAfter: lastDateAndTime [
	^TaFiniteDurationRecurrentAction fireInstant: aDateAndTime actionBlock: aBlock period: aDuration stopAfter: lastDateAndTime.

]

{ #category : #'started instance creation' }
TaAction class >> on: aDateAndTime repeat: aBlock every: aDuration times: recurrenceCount [
	^TaFiniteCountRecurrentAction fireInstant: aDateAndTime actionBlock: aBlock period: aDuration times: recurrenceCount.

]

{ #category : #accessing }
TaAction >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
TaAction >> actionBlock: anObject [
	actionBlock := anObject
]

{ #category : #accessing }
TaAction >> actionRunnerClass [
	^TaActionRunner
]

{ #category : #accessing }
TaAction >> durationTillFireInstant [
	^(self fireInstant - self now) max: 0 milliSecond
]

{ #category : #firing }
TaAction >> fire [
	self actionBlock value.

]

{ #category : #firing }
TaAction >> fireIfDue [
	self fireIfDueOn: self now.
]

{ #category : #firing }
TaAction >> fireIfDueOn: aDateAndTime [ 
	(self isDueOn: aDateAndTime) ifFalse: [^self].
	self fire.

]

{ #category : #accessing }
TaAction >> fireInstant [
	^ fireInstant
]

{ #category : #accessing }
TaAction >> fireInstant: anObject [
	fireInstant := anObject
]

{ #category : #'initialize-release' }
TaAction >> initialize [
	super initialize.
	runner := self runnerClass action: self.
]

{ #category : #firing }
TaAction >> isDueOn: aDateAndTime [
	^aDateAndTime >= self fireInstant
]

{ #category : #activity }
TaAction >> isStarted [
	^runner isStarted
]

{ #category : #activity }
TaAction >> isStopped [
	^runner isStopped
]

{ #category : #accessing }
TaAction >> now [
	^self class now
]

{ #category : #accessing }
TaAction >> runner [
	^runner
]

{ #category : #'initialize-release' }
TaAction >> runnerClass [
	^TaActionRunner
]

{ #category : #activity }
TaAction >> start [
	self runner start.
]

{ #category : #activity }
TaAction >> stop [
	self runner stop
]
