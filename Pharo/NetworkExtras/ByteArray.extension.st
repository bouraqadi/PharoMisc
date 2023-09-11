Extension { #name : #ByteArray }

{ #category : #'*NetworkExtras-converting' }
ByteArray >> asIpAddress [
	^NeIpV4Address newFrom: self
]
