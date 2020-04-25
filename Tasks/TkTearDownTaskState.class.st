Class {
	#name : #TkTearDownTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel-Tasks'
}

{ #category : #acting }
TkTearDownTaskState >> act [
	self task valueTearDownBlock
]
