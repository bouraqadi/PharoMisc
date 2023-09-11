Class {
	#name : #TkActingTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Private-Tasks'
}

{ #category : #acting }
TkActingTaskState >> act [
	self task valueActionBlock
]

{ #category : #testing }
TkActingTaskState >> isDue [
	^ self isDueTimePassed
]
