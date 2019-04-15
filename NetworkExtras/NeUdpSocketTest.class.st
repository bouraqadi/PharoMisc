Class {
	#name : #NeUdpSocketTest,
	#superclass : #NeSocketTest,
	#category : #'NetworkExtras-Test'
}

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
		NeUnicastUdpSocket target: targetIp port: port].

]

{ #category : #testing }
NeUdpSocketTest >> newUnicastUdpSocketReceivingOnPort: port [
	^self createSocket: [NeUnicastUdpSocket listenOnPort: port].

]
