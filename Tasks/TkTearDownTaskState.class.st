Class {
	#name : #TkTearDownTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel'
}

{ #category : #acting }
TkTearDownTaskState >> act [
	self task valueTearDownBlock
]
