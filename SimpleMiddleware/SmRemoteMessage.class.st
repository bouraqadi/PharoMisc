"
I resent a message captured by a proxy. After reception by the middleware that hosts the target object, the dispatcher converts me to an actual message sent to the  target.

    Instance Variables
	arguments:		<Array of Objects> 
	receiverId:		<Object> identifier of the target object
	selector:		<Symbol> 
"
Class {
	#name : #SmRemoteMessage,
	#superclass : #Object,
	#instVars : [
		'receiverId',
		'selector',
		'arguments'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #'instance creation' }
SmRemoteMessage class >> receiverId: id selector: aSymbol arguments: anArray [
	^self new
		receiverId: id;
		selector: aSymbol;
		arguments: anArray;
		yourself 

]

{ #category : #accessing }
SmRemoteMessage >> arguments [
	^ arguments
]

{ #category : #accessing }
SmRemoteMessage >> arguments: anObject [
	arguments := anObject
]

{ #category : #marshalling }
SmRemoteMessage >> doMarshallingWith: marshaller [
	^marshaller marshallRemoteMessage: self.
]

{ #category : #unmarshalling }
SmRemoteMessage >> doUnmarshallingWith: marshaller [
	^marshaller unmarshallRemoteMessage: self.
]

{ #category : #accessing }
SmRemoteMessage >> receiverId [
	^ receiverId
]

{ #category : #accessing }
SmRemoteMessage >> receiverId: anObject [
	receiverId := anObject
]

{ #category : #accessing }
SmRemoteMessage >> selector [
	^ selector
]

{ #category : #accessing }
SmRemoteMessage >> selector: anObject [
	selector := anObject
]
