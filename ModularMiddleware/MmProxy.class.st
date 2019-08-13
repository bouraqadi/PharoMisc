Class {
	#name : #MmProxy,
	#superclass : #Object,
	#instVars : [
		'id',
		'address',
		'bus'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmProxy class >> id: aSymbol address: anAddress bus: aGateway [
	^self new
		id: aSymbol address: anAddress bus: aGateway;
		yourself
]

{ #category : #'reflective operations' }
MmProxy >> doesNotUnderstand: aMessage [
	^bus send: aMessage receiverId: id address: address
]

{ #category : #'initialize-release' }
MmProxy >> id: aSymbol address: anAddress bus: aGateway [
	id := aSymbol. 
	address := anAddress.
	bus := aGateway.
]
