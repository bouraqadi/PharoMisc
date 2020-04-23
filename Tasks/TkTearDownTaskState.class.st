Class {
	#name : #TkTearDownTaskState,
	#superclass : #TkTaskState,
	#category : #Tasks
}

{ #category : #acting }
TkTearDownTaskState >> act [
	self task valueTearDownBlock
]
