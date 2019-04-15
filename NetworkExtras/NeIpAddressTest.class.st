Class {
	#name : #NeIpAddressTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeIpAddressTest >> testAddressFromString [
	self assert: 'localhost' asIpAddress equals: '127.0.0.1' asIpAddress.
	self assert: '255.255.255.255' asIpAddress equals: 'broadcasthost' asIpAddress.
	
]

{ #category : #testing }
NeIpAddressTest >> testAddressName [
	self assert: NeIpV4Address loopback name equals: 'localhost'.
	self assert: NeIpV4Address broadcast name equals: 'broadcasthost'.
	self assert: (NeIpV4Address fromName: 'localhost') equals: NeIpV4Address loopback.
	self assert: (NeIpV4Address fromName: 'broadcasthost') equals: NeIpV4Address broadcast.
	
	
]

{ #category : #testing }
NeIpAddressTest >> testCompareAddresses [
	self assert: '1.1.1.1' asIpAddress < '2.2.2.2' asIpAddress.
	self assert: '2.2.2.2' asIpAddress > '1.1.1.1' asIpAddress.
	self assert: '0.2.0.0' asIpAddress < '1.0.0.0' asIpAddress.
	self assert: '1.1.1.1' asIpAddress > '0.2.0.0' asIpAddress.
	
	
]
