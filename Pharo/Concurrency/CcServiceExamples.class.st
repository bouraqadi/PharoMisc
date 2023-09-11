"
See class side for examples of CcThread
"
Class {
	#name : #CcServiceExamples,
	#superclass : #Object,
	#category : #'Concurrency-Kernel'
}

{ #category : #examples }
CcServiceExamples class >> autoStopOnGarbageCollect [
	<example>
	|counter runner |
	counter := 0.
	runner := CcService 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 300 milliSeconds
		while: [ counter < 100 ].
	runner start
]

{ #category : #examples }
CcServiceExamples class >> countUpTo10 [
	<example>
	|counter runner |
	counter := 0.
	runner := CcService 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 100 milliSeconds
		while: [ counter < 10 ].
	runner runTillDone.

]

{ #category : #examples }
CcServiceExamples class >> pingPong [
	<example>
	|ping pong |
	Transcript open.
	ping := CcService 
		repeat: [Transcript cr; show: '--------ping']
		every: 400 milliSeconds.
	pong := CcService 
		repeat: [Transcript cr; show: 'PONG']
		every: 200 milliSeconds.
	ping start.
	pong start.
	UIManager default centeredAlert: 'click to stop' title: 'Concurrency' configure: [:any| ] .
	ping stop.
	pong stop

]
