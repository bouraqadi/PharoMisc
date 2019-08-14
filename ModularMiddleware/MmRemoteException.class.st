Class {
	#name : #MmRemoteException,
	#superclass : #Error,
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #'instance creation' }
MmRemoteException class >> on: exception [
	^self new
		messageText: exception messageText;
		yourself
]

{ #category : #accessing }
MmRemoteException >> description [
	^'Exception occured upon performing a message on a remote object'
]
