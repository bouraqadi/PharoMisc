Class {
	#name : #TkActingTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel'
}

{ #category : #acting }
TkActingTaskState >> act [
	self task valueActionBlock
]

{ #category : #testing }
TkActingTaskState >> isDue [
	^ self isDueTimePassed
]
