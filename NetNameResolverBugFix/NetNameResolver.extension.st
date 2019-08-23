Extension { #name : #NetNameResolver }

{ #category : #'*NetNameResolverBugFix' }
NetNameResolver class >> localHostAddress [
	"Return the local address of this host."
	"NetNameResolver localHostAddress"
	<todo>
	"On Mac the primitive is buggy and can return an empty IP address. Use a standard value in that case"
		
	| primAddress |
	Smalltalk os isMacOS ifTrue: [ ^self localHostAddressHackForMac ].
	self initializeNetwork.
	[ primAddress := self primLocalAddress ] on: PrimitiveFailed do: [ :err | primAddress := #[0 0 0 0] ].
	^ (primAddress = #[0 0 0 0] ifTrue: [ #[127 0 0 1] ] ifFalse: [ primAddress ]) asSocketAddress
]

{ #category : #'*NetNameResolverBugFix' }
NetNameResolver class >> localHostAddressHackForMac [
	"This is a hack. The best solution should be done by fixing the primitive on Mac"
	| ipString |
	ipString := Smalltalk os resultOfCommand: 'ipconfig getifaddr en0'. 
	ipString ifEmpty:	[^self loopBackAddress].
	^SocketAddress fromDottedString: ipString

]
