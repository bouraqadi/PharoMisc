Extension { #name : #String }

{ #category : #'*NetworkExtras-converting' }
String >> asIpAddress [
	^NeIpV4Address fromString: self
]
