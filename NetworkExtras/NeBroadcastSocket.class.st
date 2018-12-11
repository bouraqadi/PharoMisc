"
I am an UDP socket dedicated to broadcast communication.  Broadcast is meant either for the wohole network, or a sub-network depending on the used broadcastIp address. 

    Instance Variables
	broadcastIp:		<NeIpAddress> IP used as a traget of broadcasted data
	broadcastPort:		<Integer> port targeted with broadcasted data

"
Class {
	#name : #NeBroadcastSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'broadcastPort',
		'broadcastIp'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeBroadcastSocket class >> ip: ip port: portNumber [
	^self new 
		broadcastIp: ip port: portNumber;
		yourself
]

{ #category : #'instance creation' }
NeBroadcastSocket class >> port: portNumber [
	^self 
		ip: NeIpV4Address broadcast
		port: portNumber
]

{ #category : #accessing }
NeBroadcastSocket >> broadcastIp [
	^broadcastIp
]

{ #category : #'initialize-release' }
NeBroadcastSocket >> broadcastIp: anIp port: portNumber [
	anIp last = 255 ifFalse: [^NeInvalidBroadcastIp signal].
	self ensureValidPort: portNumber.
	broadcastIp := anIp asIpAddress.
	broadcastPort := portNumber.
	self setOption: 'SO_BROADCAST' value: true
]

{ #category : #accessing }
NeBroadcastSocket >> broadcastPort [
	^broadcastPort
]

{ #category : #'initialize-release' }
NeBroadcastSocket >> broadcastPort: portNumber [
	self broadcastIp: self broadcastIp port: portNumber
]

{ #category : #printing }
NeBroadcastSocket >> printSocketInfoOn: stream [
	stream
		nextPutAll: 'Target IP: ';
		print: self targetIp;
		nextPutAll: ' - port: ';
		print: self targetPort
]

{ #category : #sending }
NeBroadcastSocket >> targetIp [
	^self broadcastIp
]

{ #category : #sending }
NeBroadcastSocket >> targetPort [
	^self broadcastPort
]
