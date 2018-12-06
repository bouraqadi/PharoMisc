"
I represents an IPv4 address. 

I subclass of  ByteArray for purpose of compatibility with the existing implementation of Socket

Instances can be created either  from  a string or a byte array.
Examples:
'192.168.11.22' asIpAddress
#[192 168 11 22] asIpAddress
"
Class {
	#name : #NeIpV4Address,
	#superclass : #ByteArray,
	#type : #bytes,
	#category : #'NetworkExtras-Kernel'
}

{ #category : #'instance creation' }
NeIpV4Address class >> allNetworkInterfaces [
	"INADDR_ANY = all available network interfaces on the current device"
	^ self newFrom:  #[0 0 0 0]
]

{ #category : #'instance creation' }
NeIpV4Address class >> broadcast [
	^ self newFrom: #[255 255 255 255]
]

{ #category : #'instance creation' }
NeIpV4Address class >> fromIpString: aString [
	"return a new IP address from a string
	IPAddress fromIpString: '10.1.10.115'"
	
	^ self newFrom: ((aString splitOn: $.) collect: [:s | s asInteger])
]

{ #category : #'instance creation' }
NeIpV4Address class >> fromName: aString [
	"return a new IP address from a host name
	IPAddress fromName: 'localhost'"
	
	^ (NetNameResolver addressForName: aString) asIpAddress
]

{ #category : #'instance creation' }
NeIpV4Address class >> fromString: aString [
	(aString includes: $.) ifTrue: [ ^self fromIpString: aString ].
	^self fromName: aString

]

{ #category : #'instance creation' }
NeIpV4Address class >> local [
	"return a new IP address from a string
	IPAddress local"
	
	^ self newFrom: NetNameResolver localHostAddress
]

{ #category : #'instance creation' }
NeIpV4Address class >> loopback [
	^ self newFrom: NetNameResolver loopBackAddress
]

{ #category : #comparing }
NeIpV4Address >> < anIpAddress [
	^self asNumber < anIpAddress asNumber
]

{ #category : #comparing }
NeIpV4Address >> > anIpAddress [
	^self asNumber > anIpAddress asNumber
]

{ #category : #converting }
NeIpV4Address >> asIpAddress [
	^self
]

{ #category : #converting }
NeIpV4Address >> asNumber [
	| result coeficient |
	result := 0.
	self with: (self size to: 1 by: -1) do: [ : value : index |
		coeficient := 10 ** (index * 3).
		result := result + (value * coeficient) ].
	^result
]

{ #category : #converting }
NeIpV4Address >> asString [
	^ NetNameResolver stringFromAddress: self
]

{ #category : #accessing }
NeIpV4Address >> name [
	self = self class loopback ifTrue: [^'localhost']. "Workaround for Windows where VM answers that actual machine name!"
	^NetNameResolver nameForAddress: self timeout: 60
]
