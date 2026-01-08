Class {
	#name : 'NeLoopbackAddressMulticastSocketTest',
	#superclass : 'NeMulticastSocketTest',
	#category : 'NetworkExtras-Test',
	#package : 'NetworkExtras',
	#tag : 'Test'
}

{ #category : 'testing' }
NeLoopbackAddressMulticastSocketTest >> groupIp [

	^ NeIpV4Address loopback
]
