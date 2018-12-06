Class {
	#name : #NeUdpSocketPortTest,
	#superclass : #NeUdpSocketTest,
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeUdpSocketPortTest >> testValidBroadcastPort [
	self should: [ self newBroadcastSocketOnPort: -1 ] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newBroadcastSocketOnPort: 0 ] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newBroadcastSocketOnPort: 65535 ] raise: NeInvalidSocketPortError.
	self should: [ self newBroadcastSocketOnPort: 65536 ] raise: NeInvalidSocketPortError.

]

{ #category : #testing }
NeUdpSocketPortTest >> testValidMulticastPort [
	self should: [ self newMulticastSocketOnGroup: '226.0.0.12' port: -1] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newMulticastSocketOnGroup: '226.0.0.12' port: 0] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newMulticastSocketOnGroup: '226.0.0.12' port: 65535] raise: NeInvalidSocketPortError.
	self should: [ self newMulticastSocketOnGroup: '226.0.0.12' port: 65536] raise: NeInvalidSocketPortError.

]

{ #category : #testing }
NeUdpSocketPortTest >> testValidUnicastEmissionPort [
	self should: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: -1] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: 0] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: 65535] raise: NeInvalidSocketPortError.
	self should: [ self newUnicastUdpSocketEmittingToIp: '127.0.0.1' port: 65536] raise: NeInvalidSocketPortError.

]

{ #category : #testing }
NeUdpSocketPortTest >> testValidUnicastReceptionPort [
	self should: [ self newUnicastUdpSocketReceivingOnPort: -1 ] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newUnicastUdpSocketReceivingOnPort: 0 ] raise: NeInvalidSocketPortError.
	self shouldnt: [ self newUnicastUdpSocketReceivingOnPort: 65535 ] raise: NeInvalidSocketPortError.
	self should: [ self newUnicastUdpSocketReceivingOnPort: 65536 ] raise: NeInvalidSocketPortError.

]
