"
Shared behavior for UDP socket classes
"
Class {
	#name : #NeUdpSocketTest,
	#superclass : #TestCase,
	#instVars : [
		'allSockets'
	],
	#category : #'NetworkExtras-KernelTest'
}

{ #category : #testing }
NeUdpSocketTest class >> isAbstract [
	^self == NeUdpSocketTest 
]

{ #category : #testing }
NeUdpSocketTest >> createSocket: aBlock [
	| newSocket |
	newSocket := aBlock value.
	allSockets add: newSocket.
	^newSocket
]

{ #category : #testing }
NeUdpSocketTest >> newBroadcastSocketOnPort: port [
	^self createSocket: [NeBroadcastSocket port: port]

]

{ #category : #testing }
NeUdpSocketTest >> newMulticastSocketOnGroup: groupIp port: port [
	^self createSocket: [NeMulticastSocket
				group: groupIp
				port: port].

]

{ #category : #testing }
NeUdpSocketTest >> newUnicastUdpSocketEmittingToIp: targetIp port: port [
	^self createSocket: [
		NeUnicastUdpSocket targetIpOrName: targetIp port: port].

]

{ #category : #testing }
NeUdpSocketTest >> newUnicastUdpSocketReceivingOnPort: port [
	^self createSocket: [NeUnicastUdpSocket receptionPort: port].

]

{ #category : #testing }
NeUdpSocketTest >> setUp [
	super setUp.
	allSockets := Set new.

]

{ #category : #testing }
NeUdpSocketTest >> tearDown [
	super tearDown.	
	allSockets do: #closeAndDestroy.

]
