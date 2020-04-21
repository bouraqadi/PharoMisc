"
I am incharge of running an action, ie once started, I ensure it will fire at the right time.

Public API and Key Messages
- action: anAction
Initializes the action to run   
- start
Begins running, i.e. watch time and fires the action at the right instant
-stop
Stops running
-isStarted
Answers true if I am started
-isStopped
Answers false if I am stopped

Instance Variables
	action:		<TaAction> action to run
	process:		<Process> The process in which the action is performed
	activityLock:		<Mutex> synchronize concurrent accesses, typically if stop or other state related methods are performed by another process



"
Class {
	#name : #TaActionRunner,
	#superclass : #Object,
	#instVars : [
		'process',
		'action',
		'activityLock'
	],
	#category : #TimedAction
}

{ #category : #'instance creation' }
TaActionRunner class >> action: anAction [
	^self new
		action: anAction;
		yourself
]

{ #category : #'initialize-release' }
TaActionRunner >> action: anAction [
	action := anAction
]

{ #category : #private }
TaActionRunner >> basicStart [
	process := [self fireIfDueLoop] forkNamed: self className.
]

{ #category : #private }
TaActionRunner >> basicStop [
	|oldProcess|
	oldProcess := process.
	process := nil.
	oldProcess terminate.
	"After this line will, nothing will be executed!"

]

{ #category : #private }
TaActionRunner >> fireIfDue [
	action fireIfDue
]

{ #category : #private }
TaActionRunner >> fireIfDueLoop [
	[
		self sleepDuration wait.
		self fireIfDue
	] repeat.
]

{ #category : #private }
TaActionRunner >> fireInstant [
	^action fireInstant
]

{ #category : #activity }
TaActionRunner >> ifStarted: aBlock [
	self
		ifStarted: aBlock
		ifStopped: nil
]

{ #category : #activity }
TaActionRunner >> ifStarted: startBlock ifStopped: stopBlock [
	activityLock critical: [  
		process ifNil: [ ^stopBlock value ].
		startBlock value
	]

]

{ #category : #activity }
TaActionRunner >> ifStopped: aBlock [
	self
		ifStarted: nil
		ifStopped: aBlock
]

{ #category : #'initialize-release' }
TaActionRunner >> initialize [
	super initialize.
	activityLock := Mutex new.

]

{ #category : #activity }
TaActionRunner >> isStarted [
	^self isStopped not
]

{ #category : #activity }
TaActionRunner >> isStopped [
	self 
		ifStarted: [ ^false ]
		ifStopped: [ ^true ].

]

{ #category : #private }
TaActionRunner >> sleepDuration [
	^action durationTillFireInstant
]

{ #category : #activity }
TaActionRunner >> start [
	self ifStopped: [ self basicStart ] 

]

{ #category : #activity }
TaActionRunner >> stop [
	self ifStarted: [ self basicStop ] 

]
