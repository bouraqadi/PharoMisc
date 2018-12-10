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
NeUnicastUdpSocket class >> targetIpOrName: ip port: portNumber [
	^self newUDP
		targetIpOrName: ip;
		targetPort: portNumber;
		yourself
]

{ #category : #sending }
NeUnicastUdpSocket >> send: anObject targetIp: ipAddress port: portNumber [
	self targetIpOrName: ipAddress.
	self targetPort: portNumber.
	^self send: anObject
]

{ #category : #sending }
NeUnicastUdpSocket >> targetIp [
	^ targetIp
]

{ #category : #accessing }
NeUnicastUdpSocket >> targetIpOrName: anObject [
	targetIp := anObject asIpAddress

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
