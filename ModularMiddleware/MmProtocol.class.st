Class {
	#name : #MmProtocol,
	#superclass : #Object,
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #serializing }
MmProtocol >> materializeFromByteArray: anObject [
	^FLMaterializer materializeFromByteArray: anObject
]

{ #category : #serializing }
MmProtocol >> serializeToByteArray: anObject [
	^FLSerializer serializeToByteArray: anObject
]
