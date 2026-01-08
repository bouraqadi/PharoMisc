Class {
	#name : 'NeLoopbackAddressMulticastUdpServerTest',
	#superclass : 'NeMulticastUdpServerTest',
	#category : 'NetworkExtras-Test',
	#package : 'NetworkExtras',
	#tag : 'Test'
}

{ #category : 'testing' }
NeLoopbackAddressMulticastUdpServerTest >> groupIp [

	^ NeIpV4Address loopback
]
