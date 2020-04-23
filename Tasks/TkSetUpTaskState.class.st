Class {
	#name : #TkSetUpTaskState,
	#superclass : #TkTaskState,
	#category : #Tasks
}

{ #category : #acting }
TkSetUpTaskState >> act [
	self task valueSetUpBlock
]
