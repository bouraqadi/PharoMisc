Class {
	#name : #MmMessage,
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
MmMessage class >> selector: selector arguments: args receiver: receiver resultId: resultId [
	^self new
		selector: selector; 
		arguments: args; 
		receiver: receiver;
		resultId: resultId; 
		yourself

]

{ #category : #accessing }
MmMessage >> arguments [
	^ arguments
]

{ #category : #accessing }
MmMessage >> arguments: anObject [
	arguments := anObject
]

{ #category : #marshalling }
MmMessage >> marshalWith: aMarshaller [
	^aMarshaller marshalMessage: self
]

{ #category : #accessing }
MmMessage >> receiver [
	^ receiver
]

{ #category : #accessing }
MmMessage >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
MmMessage >> resultId [
	^ resultId
]

{ #category : #accessing }
MmMessage >> resultId: anObject [
	resultId := anObject
]

{ #category : #accessing }
MmMessage >> selector [
	^ selector
]

{ #category : #accessing }
MmMessage >> selector: anObject [
	selector := anObject
]

{ #category : #performing }
MmMessage >> send [
	^self receiver
		perform: selector 
		withArguments: arguments
]

{ #category : #marshalling }
MmMessage >> unmarshalWith: aMarshaller [
	^aMarshaller unmarshalMessage: self
]
