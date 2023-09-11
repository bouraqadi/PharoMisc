Class {
	#name : #TkPendingTaskState,
	#superclass : #TkTaskState,
	#category : #'Tasks-Private-Tasks'
}

{ #category : #initialization }
TkPendingTaskState >> actAfter: aDuration [
	self dueTime: self now + aDuration
]

{ #category : #testing }
TkPendingTaskState >> isDue [
	^self isDueTimePassed
]
