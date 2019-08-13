Class {
	#name : #MmMiddleware,
	#superclass : #Object,
	#instVars : [
		'bus'
	],
	#category : #'ModularMiddleware-Kernel'
}

{ #category : #communicating }
MmMiddleware >> address [
	^nil
]

{ #category : #communicating }
MmMiddleware >> bus [
	^bus
]

{ #category : #'initialize-release' }
MmMiddleware >> bus: aBus [
	bus := aBus
]

{ #category : #'initialize-release' }
MmMiddleware >> defaultBusClass [
	^MmBus
]

{ #category : #communicating }
MmMiddleware >> export: anObject as: aString [ 
	^self
]

{ #category : #'initialize-release' }
MmMiddleware >> initialize [
	super initialize.
	self bus: self defaultBusClass new
]

{ #category : #activity }
MmMiddleware >> isStarted [
	^self bus isStarted
]

{ #category : #activity }
MmMiddleware >> isStopped [
	^self isStarted not
]

{ #category : #activity }
MmMiddleware >> onStartDo: aBlockClosure [ 
	self bus onStartDo: aBlockClosure 
]

{ #category : #activity }
MmMiddleware >> onStopDo: aBlockClosure [ 
	self bus onStopDo: aBlockClosure 
]

{ #category : #communicating }
MmMiddleware >> proxyId: aSymbol address: anAddress [ 
	^MmProxy id: aSymbol address: anAddress bus: self bus
]

{ #category : #activity }
MmMiddleware >> start [
	self bus start
]

{ #category : #activity }
MmMiddleware >> stop [
	self bus stop
]
