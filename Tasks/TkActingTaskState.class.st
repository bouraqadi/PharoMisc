Class {
	#name : #TkActingTaskState,
	#superclass : #TkTaskState,
	#category : #Tasks
}

{ #category : #acting }
TkActingTaskState >> act [
	self task valueActionBlock
]
