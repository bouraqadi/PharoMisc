Class {
	#name : #TkThreadTestBench,
	#superclass : #TkTestBench,
	#instVars : [
		'thread'
	],
	#category : #'Tasks-Tests'
}

{ #category : #creating }
TkThreadTestBench >> thread: aThread [
	^thread := aThread.
]

{ #category : #creating }
TkThreadTestBench >> threadClass [
	^TkThread
]

{ #category : #creating }
TkThreadTestBench >> threadPeriod100Milliseconds [
	^self thread: (self threadClass repeat: self actionBlock until: self flagBlock every: 100 milliSeconds ).

]

{ #category : #creating }
TkThreadTestBench >> threadRepeatingForever [
	^self thread: (self threadClass repeat: self actionBlock).

]
