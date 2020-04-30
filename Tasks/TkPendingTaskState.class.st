Class {
	#name : #TkPendingTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Kernel-Tasks'
}

{ #category : #initialization }
TkPendingTaskState >> actAfter: aDuration [
	self dueTime: self now + aDuration
]

{ #category : #testing }
TkPendingTaskState >> isDue [
	^self isDueTimePassed
]
