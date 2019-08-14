Class {
	#name : #MmRemoteMessage,
	#superclass : #Object,
	#instVars : [
		'selector',
		'arguments',
		'receiverId',
		'resultId'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmRemoteMessage class >> selector: selector arguments: args receiverId: receiverId resultId: resultId [
	^self new
		selector: selector; 
		arguments: args; 
		receiverId: receiverId;
		resultId: resultId; 
		yourself

]

{ #category : #accessing }
MmRemoteMessage >> arguments [
	^ arguments
]

{ #category : #accessing }
MmRemoteMessage >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
MmRemoteMessage >> receiverId [
	^ receiverId
]

{ #category : #accessing }
MmRemoteMessage >> receiverId: anObject [
	receiverId := anObject
]

{ #category : #accessing }
MmRemoteMessage >> resultId [
	^ resultId
]

{ #category : #accessing }
MmRemoteMessage >> resultId: anObject [
	resultId := anObject
]

{ #category : #accessing }
MmRemoteMessage >> selector [
	^ selector
]

{ #category : #accessing }
MmRemoteMessage >> selector: anObject [
	selector := anObject
]

{ #category : #performing }
MmRemoteMessage >> sendTo: anObject [ 
	^anObject
		perform: selector 
		withArguments: arguments
]
