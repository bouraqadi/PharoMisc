Class {
	#name : #TkPendingTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel-Tasks'
}

{ #category : #testing }
TkPendingTaskState >> isDue [
	^self isDueTimePassed
]

{ #category : #initialization }
TkPendingTaskState >> startAfter: aDuration [
	self dueTime: self now + aDuration
]
