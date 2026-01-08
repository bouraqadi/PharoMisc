"
Multicast test that require being on a network with a router that enables multicast communication
"
Class {
	#name : 'NeRoutedAddressMulticastUdpServerTest',
	#superclass : 'NeMulticastUdpServerTest',
	#category : 'NetworkExtras-Test',
	#package : 'NetworkExtras',
	#tag : 'Test'
}

{ #category : 'testing' }
NeRoutedAddressMulticastUdpServerTest >> groupIp [

	^ '226.1.2.3'
]
