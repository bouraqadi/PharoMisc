Class {
	#name : #MmInboundChannel,
	#superclass : #MmChannel,
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #receiving }
MmInboundChannel >> receiveObject: remoteMessage [
	|  result response remoteException |
	[
		result := remoteMessage send. 
		response := MmNormalResponse id: remoteMessage resultId result: result.
	] on: Exception
	  do: [ : exception |
		remoteException := MmRemoteException on: exception.
		response := MmExceptionResponse id: remoteMessage resultId exception: remoteException.
		].
	self sendObject: response


]
