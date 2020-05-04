Class {
	#name : #TkSetUpTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Private-Tasks'
}

{ #category : #acting }
TkSetUpTaskState >> act [
	self task valueSetUpBlock
]
