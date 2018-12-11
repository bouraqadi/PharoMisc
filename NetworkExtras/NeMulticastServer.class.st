"
I am a UDP Multicast server. I handle incoming UDP data repeatedly in a dedicated thread.

"
Class {
	#name : #NeMulticastServer,
	#superclass : #NeUdpServer,
	#instVars : [
		'groupIp',
		'portNumber'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeMulticastServer class >> group: ipOrName port: portNumber [
	^self new
		groupIp: ipOrName;
		portNumber: portNumber;
		yourself
]

{ #category : #activity }
NeMulticastServer >> defaultServerName [
	^'Multicast server'
]

{ #category : #accessing }
NeMulticastServer >> groupIp [
	^ groupIp
]

{ #category : #accessing }
NeMulticastServer >> groupIp: anObject [
	groupIp := anObject
]

{ #category : #building }
NeMulticastServer >> newSocket [
	^NeMulticastSocket group: self groupIp port: self portNumber
]

{ #category : #accessing }
NeMulticastServer >> portNumber [
	^ portNumber
]

{ #category : #accessing }
NeMulticastServer >> portNumber: anObject [
	portNumber := anObject
]
