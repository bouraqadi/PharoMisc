Class {
	#name : #TkKilledThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Kernel-Threads'
}

{ #category : #testing }
TkKilledThreadState >> isKilled [
	^true
]

{ #category : #living }
TkKilledThreadState >> kill [
	^self
]
