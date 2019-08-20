Class {
	#name : #MmRemoteMessage,
	#superclass : #Object,
	#instVars : [
		'selector',
		'arguments',
		'receiver',
		'resultId'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmRemoteMessage class >> selector: selector arguments: args receiver: receiver resultId: resultId [
	^self new
		selector: selector; 
		arguments: args; 
		receiver: receiver;
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

{ #category : #marshalling }
MmRemoteMessage >> marshalWith: aMarshaller [
	^aMarshaller marshalMessage: self
]

{ #category : #accessing }
MmRemoteMessage >> receiver [
	^ receiver
]

{ #category : #accessing }
MmRemoteMessage >> receiver: anObject [
	receiver := anObject
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
MmRemoteMessage >> send [
	^self receiver
		perform: selector 
		withArguments: arguments
]

{ #category : #marshalling }
MmRemoteMessage >> unmarshalWith: aMarshaller [
	^aMarshaller unmarshalMessage: self
]
