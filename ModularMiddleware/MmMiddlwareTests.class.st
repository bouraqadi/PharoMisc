Class {
	#name : #MmMiddlwareTests,
	#superclass : #TestCase,
	#instVars : [
		'middlewareA',
		'middlewareB'
	],
	#category : #'ModularMiddleware-Tests'
}

{ #category : #tests }
MmMiddlwareTests >> assertIsProxy: anObject [
		self assert: (self isProxy: anObject). 

]

{ #category : #tests }
MmMiddlwareTests >> denyIsProxy: anObject [
		self deny: (self isProxy: anObject). 

]

{ #category : #tests }
MmMiddlwareTests >> isProxy: anObject [
	^anObject isKindOf: MmProxy

]

{ #category : #tests }
MmMiddlwareTests >> middlewareClass [
	^ MmLocalMiddleware
]

{ #category : #tests }
MmMiddlwareTests >> newValueHolder [
	^ ValueHolder new
]

{ #category : #tests }
MmMiddlwareTests >> passByCopyObjects [
	^{'Hello Pharo'. 958. 3.14. false. true. nil. $a. 3/2} 
]

{ #category : #tests }
MmMiddlwareTests >> passByReferenceObjects [
	^{Object new. Class. #(). Set new. [1+2]}
]

{ #category : #tests }
MmMiddlwareTests >> setUp [
	super setUp.
	middlewareA := 	self middlewareClass new.
	middlewareB := 	self middlewareClass new.

]

{ #category : #tests }
MmMiddlwareTests >> testArgPassByCopy [
	| valueHolder proxy remoteReference |
	valueHolder := self newValueHolder.
	remoteReference := middlewareA export: valueHolder.
	proxy := middlewareB proxyAt: remoteReference.
	self passByCopyObjects do: [ : arg |
		proxy contents: arg.
		self denyIsProxy: valueHolder contents. 
		self assert: valueHolder contents equals: arg]
	

]

{ #category : #tests }
MmMiddlwareTests >> testArgPassByReference [
	| valueHolder proxy remoteReference |
	valueHolder := self newValueHolder.
	remoteReference := middlewareA export: valueHolder.
	proxy := middlewareB proxyAt: remoteReference.
	self passByReferenceObjects do: [ : arg |
		proxy contents: arg.
		self assertIsProxy: valueHolder contents.
		self assert: valueHolder contents == valueHolder contents.
		self deny: valueHolder contents == proxy]
	

]

{ #category : #tests }
MmMiddlwareTests >> testArgProxyToObjectInThirdMiddleware [
	self fail: #todo
]

{ #category : #tests }
MmMiddlwareTests >> testException [
	| remoteReference proxy |
	remoteReference := middlewareA export: Object new.
	proxy := middlewareB proxyAt: remoteReference.
	self should: [proxy foo] raise: MmRemoteException
]

{ #category : #tests }
MmMiddlwareTests >> testProxyCreatedOnDemand [
	| remoteReference proxy |
	remoteReference := middlewareA export: self newValueHolder.
	proxy := middlewareB proxyAt: remoteReference.
	self assertIsProxy: proxy
]

{ #category : #tests }
MmMiddlwareTests >> testProxyCreatedOnlyOnce [
	| remoteReference proxy1 proxy2 |
	remoteReference := middlewareA export: self newValueHolder.
	proxy1 := middlewareB proxyAt: remoteReference.
	proxy2 := middlewareB proxyAt: remoteReference.
	self assert: proxy1 == proxy2.
	
]

{ #category : #tests }
MmMiddlwareTests >> testProxyCreation [
	| remoteReference proxy |
	remoteReference := middlewareA export: self newValueHolder.
	proxy := middlewareB newProxyTo: remoteReference.
	self assertIsProxy: proxy
]

{ #category : #tests }
MmMiddlwareTests >> testProxyOnBlock [
	| remoteReference proxy |
	remoteReference := middlewareA export: [1+2].
	proxy := middlewareB newProxyTo: remoteReference.
	self assert: proxy value equals: 3
]

{ #category : #tests }
MmMiddlwareTests >> testProxyYourself [
	| remoteReference proxy |
	remoteReference := middlewareA export: self newValueHolder.
	proxy := middlewareB newProxyTo: remoteReference.
	self assert: proxy yourself == proxy
]

{ #category : #tests }
MmMiddlwareTests >> testResultPassByCopy [
	| valueHolder proxy remoteReference |
	valueHolder := self newValueHolder.
	remoteReference := middlewareA export: valueHolder.
	proxy := middlewareB proxyAt: remoteReference.
	self passByCopyObjects do: [ : arg |
		valueHolder contents: arg.
		self denyIsProxy: proxy contents. 
		self assert: proxy contents equals: arg]

]

{ #category : #tests }
MmMiddlwareTests >> testResultPassByReference [
	| valueHolder proxy remoteReference |
	valueHolder := self newValueHolder.
	remoteReference := middlewareA export: valueHolder.
	proxy := middlewareB proxyAt: remoteReference.
	self passByReferenceObjects do: [ : arg |
		valueHolder contents: arg.
		self assertIsProxy: proxy contents.
		self assert: proxy contents == proxy contents.
		self deny: proxy contents == proxy]

]

{ #category : #tests }
MmMiddlwareTests >> testResultProxyToObjectInThirdMiddleware [
	self fail: #todo
]
