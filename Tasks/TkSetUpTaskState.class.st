Class {
	#name : #TkSetUpTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel'
}

{ #category : #acting }
TkSetUpTaskState >> act [
	self task valueSetUpBlock
]
