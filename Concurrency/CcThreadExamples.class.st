"
See class side for examples of CcThread
"
Class {
	#name : #CcThreadExamples,
	#superclass : #Object,
	#category : #'Concurrency-Kernel'
}

{ #category : #examples }
CcThreadExamples class >> autoStopOnGarbageCollect [
	<example>
	|counter runner |
	counter := 0.
	runner := CcThread 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 300 milliSeconds
		while: [ counter < 100 ].
	runner start
]

{ #category : #examples }
CcThreadExamples class >> countUpTo10 [
	<example>
	|counter runner |
	counter := 0.
	runner := CcThread 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 100 milliSeconds
		while: [ counter < 10 ].
	runner runTillDone.

]

{ #category : #examples }
CcThreadExamples class >> pingPong [
	<example>
	|ping pong |
	Transcript open.
	ping := CcThread 
		repeat: [Transcript cr; show: '--------ping']
		every: 400 milliSeconds.
	pong := CcThread 
		repeat: [Transcript cr; show: 'PONG']
		every: 200 milliSeconds.
	ping start.
	pong start.
	UIManager default centeredAlert: 'click to stop' title: 'Concurrency' configure: [:any| ] .
	ping stop.
	pong stop

]
