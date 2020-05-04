Class {
	#name : #TkTearDownTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Private-Tasks'
}

{ #category : #acting }
TkTearDownTaskState >> act [
	self task valueTearDownBlock
]
