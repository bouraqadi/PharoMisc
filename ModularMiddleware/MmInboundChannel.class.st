Class {
	#name : #MmInboundChannel,
	#superclass : #MmChannel,
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #receiving }
MmInboundChannel >> receiveObject: remoteMessage [
	|  result response |
	[
		result := remoteMessage send. 
		response := MmNormalResponse id: remoteMessage resultId result: result.
	] on: Exception
	  do: [ : exception |
		response := MmExceptionResponse id: remoteMessage resultId exception: exception.
		].
	self sendObject: response


]
