"
See class side for examples of ActiveObject
"
Class {
	#name : #ActiveObjectExamples,
	#superclass : #Object,
	#category : #'Concurrency-Kernel'
}

{ #category : #examples }
ActiveObjectExamples class >> autoStopCounter [
	"self autoStopCounter"
	|counter runner |
	counter := 0.
	runner := ActiveObject 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 300 milliSeconds
		while: [ counter < 10 ].
	runner start
]

{ #category : #examples }
ActiveObjectExamples class >> countUpTo10 [
	"self countUpTo10"
	|counter runner |
	counter := 0.
	runner := ActiveObject 
		repeat: [
			counter := counter + 1.
			self inform: counter printString]
		every: 100 milliSeconds
		while: [ counter < 10 ].
	runner runTillDone.

]

{ #category : #examples }
ActiveObjectExamples class >> pingPong [
	"self pingPong"
	|ping pong |
	Transcript open.
	ping := ActiveObject 
		repeat: [Transcript cr; show: '--------ping']
		every: 400 milliSeconds.
	pong := ActiveObject 
		repeat: [Transcript cr; show: 'PONG']
		every: 200 milliSeconds.
	ping start.
	pong start.
	UIManager default centeredAlert: 'click to stop' title: 'Concurrency' configure: [:any| ] .
	ping stop.
	pong stop

]
