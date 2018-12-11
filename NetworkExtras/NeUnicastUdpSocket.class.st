"
I am an UDP socket dedicated to unicast communication. I store the target IP and the Port of  the target, to make it easy to send different datagrams to the same target. 

 Instance Variables
	targetIp:		<NeIpAddress> Ip of the socket to which I send data
 	targetPort	<Integer>  port of the socket to which I send data

"
Class {
	#name : #NeUnicastUdpSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'targetIp',
		'targetPort'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeUnicastUdpSocket class >> receptionPort: portNumber [
	^self newUDP
		receptionPort: portNumber;
		yourself
]

{ #category : #'instance creation' }
NeUnicastUdpSocket class >> target: ip port: portNumber [
	^self newUDP
		target: ip;
		targetPort: portNumber;
		yourself
]

{ #category : #printing }
NeUnicastUdpSocket >> printSocketInfoOn: stream [
	self targetPort ifNil: [  
		^stream
			nextPutAll: 'Reception port: ';
			print: self receptionPort
		].
	stream
		nextPutAll: 'Target IP: ';
		print: self targetIp;
		nextPutAll: ' - port: ';
		print: self targetPort
]

{ #category : #sending }
NeUnicastUdpSocket >> send: anObject targetIp: ipAddress port: portNumber [
	self target: ipAddress.
	self targetPort: portNumber.
	^self send: anObject
]

{ #category : #accessing }
NeUnicastUdpSocket >> target: ipOrName [
	self targetIp: ipOrName asIpAddress

]

{ #category : #sending }
NeUnicastUdpSocket >> targetIp [
	^ targetIp
]

{ #category : #accessing }
NeUnicastUdpSocket >> targetIp: anIpAddress [
	targetIp := anIpAddress

]

{ #category : #sending }
NeUnicastUdpSocket >> targetPort [
	^ targetPort
]

{ #category : #accessing }
NeUnicastUdpSocket >> targetPort: anInteger [
	self ensureValidPort: anInteger.
	targetPort := anInteger
]
