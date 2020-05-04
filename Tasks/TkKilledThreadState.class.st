Class {
	#name : #TkKilledThreadState,
	#superclass : #TkThreadState,
	#category : #'Tasks-Private-Thread'
}

{ #category : #testing }
TkKilledThreadState >> isKilled [
	^true
]

{ #category : #accessing }
TkKilledThreadState >> name [
	^'Killed'
]
