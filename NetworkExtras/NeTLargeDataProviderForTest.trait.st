"
I provide data of multiple size useful for test purpose
"
Trait {
	#name : #NeTLargeDataProviderForTest,
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTLargeDataProviderForTest >> get100KBytesOfSourceFile [
	^ SmalltalkImage current sourcesFile readStream next: 100000
]

{ #category : #testing }
NeTLargeDataProviderForTest >> get10KBytesOfSourceFile [
	^SmalltalkImage current sourcesFile readStream next: 10000
]

{ #category : #testing }
NeTLargeDataProviderForTest >> get50KBytesOfSourceFile [
	^ SmalltalkImage current sourcesFile readStream next: 50000
]

{ #category : #testing }
NeTLargeDataProviderForTest >> get5KBytesOfSourceFile [
	^ self get50KBytesOfSourceFile last: 5000
]
