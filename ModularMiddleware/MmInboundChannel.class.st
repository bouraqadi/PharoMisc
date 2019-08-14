Class {
	#name : #MmInboundChannel,
	#superclass : #MmChannel,
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #receiving }
MmInboundChannel >> receiveObject: remoteMessage [
	| receiver result response remoteException |
	receiver := self objectAt: remoteMessage receiverId.
	[
		result := remoteMessage sendTo: receiver. 
		response := MmNormalRemoteResponse id: remoteMessage resultId response: result.
	] on: Exception
	  do: [ : exception |
		remoteException := MmRemoteException on: exception.
		response := MmExceptionRemoteResponse id: remoteMessage resultId response: remoteException.
		].
	self sendObject: response


]
