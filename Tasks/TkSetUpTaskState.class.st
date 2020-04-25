Class {
	#name : #TkSetUpTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel-Tasks'
}

{ #category : #acting }
TkSetUpTaskState >> act [
	self task valueSetUpBlock
]
