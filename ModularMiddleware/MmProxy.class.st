Class {
	#name : #MmProxy,
	#superclass : #Object,
	#instVars : [
		'channel',
		'remoteReference'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmProxy class >> channel: aChannel remoteReference: aRemoteReference [
	^ self new
		channel: aChannel remoteReference: aRemoteReference;
		yourself
]

{ #category : #'initialize-release' }
MmProxy >> channel: aChannel remoteReference: aRemoteReference [
	remoteReference := aRemoteReference. 
	channel := aChannel.
]

{ #category : #'reflective operations' }
MmProxy >> doesNotUnderstand: aMessage [
	^channel send: aMessage to: self
]

{ #category : #marshalling }
MmProxy >> marshalWith: marshaller [
	^marshaller marshalRemoteReference: remoteReference
]
