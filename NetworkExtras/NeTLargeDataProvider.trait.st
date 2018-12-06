"
I provide data of multiple size useful for test purpose
"
Trait {
	#name : #NeTLargeDataProvider,
	#category : #'NetworkExtras-UDP-LargeDataTransmission'
}

{ #category : #testing }
NeTLargeDataProvider >> get100KBytesOfSourceFile [
	^ SmalltalkImage current sourcesFile readStream next: 100000
]

{ #category : #testing }
NeTLargeDataProvider >> get10KBytesOfSourceFile [
	^SmalltalkImage current sourcesFile readStream next: 10000
]

{ #category : #testing }
NeTLargeDataProvider >> get50KBytesOfSourceFile [
	^ SmalltalkImage current sourcesFile readStream next: 50000
]

{ #category : #testing }
NeTLargeDataProvider >> get5KBytesOfSourceFile [
	^ self get50KBytesOfSourceFile last: 5000
]
