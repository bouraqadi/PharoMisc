"
I am an UDP socket dedicated to multicast communication.  I can join and leave a group.

When enabling loopback mode, I receive a copy of datagrams I send.

By default, multicast datagrams are sent with a default TTL (Time To Leave) value of 1, to prevent them to be forwarded beyond the local network. Setting TTL to other values enable receivers to forward data to other networks they are connected to. The TTL is decremented upon each forward, when reaching 0, data is not forwarded anymore.

I use the same port for sending and receiving data.

More on Multicast sockets at: http://www.tldp.org/HOWTO/Multicast-HOWTO.html

    Instance Variables
	groupAddress:		<NeIpAddress>
	networkInterfaceIp:		<NeIpAddress>


    Implementation Points
"
Class {
	#name : #NeMulticastSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'groupAddress',
		'networkInterfaceIp'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeMulticastSocket class >> group: groupIp port: anInteger [
	^self new
		group: groupIp port: anInteger;
		yourself
]

{ #category : #'initialize-destroy' }
NeMulticastSocket >> close [
	[self leaveGroup] ensure: [
		super close]
]

{ #category : #accessing }
NeMulticastSocket >> defaultNetworkInterfaceIp [
	^NeIpV4Address allNetworkInterfaces
]

{ #category : #'initialize-destroy' }
NeMulticastSocket >> group: anIpAddress port: aPortNumber [
	"The group IP address must be within the range: 224.0.0.0 - 239.255.255.255"
	self setPort: aPortNumber.
	self groupAddress: anIpAddress.
	self joinGroup.
]

{ #category : #accessing }
NeMulticastSocket >> groupAddress [
	^ groupAddress
]

{ #category : #accessing }
NeMulticastSocket >> groupAddress: aStringOrIPAddress [ 
	groupAddress := aStringOrIPAddress asIpAddress.
	(groupAddress < self minGroupAddress 
		or: [groupAddress > self maxGroupAddress]) 
			ifTrue: [ NeInvalidMulticastGroupIpError signal].
]

{ #category : #accessing }
NeMulticastSocket >> groupPort [
	^self receptionPort
]

{ #category : #accessing }
NeMulticastSocket >> isLoopbackModeEnabled [	
	^ (self getOption: 'IP_MULTICAST_LOOP') last = 1
]

{ #category : #accessing }
NeMulticastSocket >> isLoopbackModeEnabled: aBoolean [
	"When enabling loopback mode, I receive a copy of datagrams I send."
	
	self setOption: 'IP_MULTICAST_LOOP' value: aBoolean
]

{ #category : #'group membership' }
NeMulticastSocket >> joinGroup [
	self setOption: 'IP_ADD_MEMBERSHIP' value: self joinParams
]

{ #category : #'group membership' }
NeMulticastSocket >> joinParams [
	| joinParams |
	joinParams := self groupAddress asOrderedCollection.
	joinParams addAll: self networkInterfaceIp.
	^ joinParams asByteArray
]

{ #category : #'group membership' }
NeMulticastSocket >> leaveGroup [
		self setOption: 'IP_DROP_MEMBERSHIP' value: self joinParams
]

{ #category : #accessing }
NeMulticastSocket >> maxGroupAddress [
	^#[239 255 255 255] asIpAddress
]

{ #category : #accessing }
NeMulticastSocket >> minGroupAddress [
	^#[224 0 0 0] asIpAddress
]

{ #category : #accessing }
NeMulticastSocket >> networkInterface [
	^ self getOption: 'IP_MULTICAST_IF'
]

{ #category : #accessing }
NeMulticastSocket >> networkInterfaceIp [
	^networkInterfaceIp ifNil: [ self defaultNetworkInterfaceIp ]
]

{ #category : #accessing }
NeMulticastSocket >> networkInterfaceIp: newAddress [
	networkInterfaceIp :=  newAddress asIpAddress.	
	self setOption: 'IP_MULTICAST_IF' value: networkInterfaceIp.
]

{ #category : #printing }
NeMulticastSocket >> printSocketInfoOn: stream [
	stream
		nextPutAll: 'Group IP: ';
		print: self groupAddress;
		nextPutAll: ' - port: ';
		print: self groupPort
]

{ #category : #sending }
NeMulticastSocket >> targetIp [
	^self groupAddress

]

{ #category : #sending }
NeMulticastSocket >> targetPort [
	^self groupPort.
]

{ #category : #sending }
NeMulticastSocket >> timeToLiveOptionId [
		^'IP_MULTICAST_TTL'
]
