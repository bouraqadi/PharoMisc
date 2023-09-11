Class {
	#name : #LoAutomaticEventGenerationTest,
	#superclass : #TestCase,
	#instVars : [
		'subject'
	],
	#category : #'LightweightObserver-Test'
}

{ #category : #running }
LoAutomaticEventGenerationTest >> setUp [
	super setUp.
	subject := LoSubjectForTest new
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testObservingAnyIvChange [
	| changeCounter |
	changeCounter := 0.
	subject afterChangeDo: [changeCounter := changeCounter + 1 ].
	subject a: #someValue.
	self assert: changeCounter equals: 1.
	subject b: #otherValue.
	self assert: changeCounter equals: 2.
	
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testObservingMultipleIvsNewValues [
	| aLastValue bLastValue |
	subject afterChangeDo: [: event | 
		aLastValue := event newValueFor: #a.
		bLastValue := event newValueFor: #b ].
	subject a: #someValue b: #otherValue.
	self assert: aLastValue equals: #someValue.
	self assert: bLastValue equals: #otherValue.
	
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testObservingSpecificIvChange [
	| aChangeCounter bChangeCounter |
	aChangeCounter := 0.
	bChangeCounter := 0.
	subject afterChangeOf: #a do: [aChangeCounter := aChangeCounter + 1 ].
	subject afterChangeOf: #b do: [bChangeCounter := bChangeCounter + 1 ].
	subject a: #someValue.
	self assert: aChangeCounter equals: 1.
	self assert: bChangeCounter equals: 0.
	subject b: #otherValue.
	self assert: aChangeCounter equals: 1.
	self assert: bChangeCounter equals: 1.
	
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testObservingSpecificIvNewValue [
	| aLastValue bLastValue |
	subject afterChangeOf: #a do: [: newValue | aLastValue := newValue ].
	subject afterChangeOf: #b do: [: newValue | bLastValue := newValue].
	subject a: #someValue.
	self assert: aLastValue equals: #someValue.
	subject b: #otherValue.
	self assert: bLastValue equals: #otherValue.
	
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testPerformingMessagesWithoutObserving [
	subject a: #someValue.
	self assert: subject a equals: #someValue.
	subject b: #otherValue.
	self assert: subject b equals: #otherValue.
	
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testRestartObservingAnyIvChange [
	| changeCounter observer |
	changeCounter := 0.
	observer := subject afterChangeDo: [changeCounter := changeCounter + 1 ].
	observer stopObserving.
	subject a: #someValue.
	observer startObserving.
	self assert: changeCounter equals: 0.
	subject b: #otherValue.
	self assert: changeCounter equals: 1.
	
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testStopObservingAnyIvChange [
	| changeCounter observer |
	changeCounter := 0.
	observer := subject afterChangeDo: [changeCounter := changeCounter + 1 ].
	observer stopObserving.
	subject a: #someValue.
	self assert: changeCounter equals: 0.
	subject b: #otherValue.
	self assert: changeCounter equals: 0.
	
]

{ #category : #testing }
LoAutomaticEventGenerationTest >> testStopObservingSpecificIvChange [
	| aChangeCounter bChangeCounter observer |
	aChangeCounter := 0.
	bChangeCounter := 0.
	observer := subject afterChangeOf: #a do: [aChangeCounter := aChangeCounter + 1 ].
	subject afterChangeOf: #b do: [bChangeCounter := bChangeCounter + 1 ].
	observer stopObserving.
	subject a: #someValue.
	self assert: aChangeCounter equals: 0.
	self assert: bChangeCounter equals: 0.
	subject b: #otherValue.
	self assert: aChangeCounter equals: 0.
	self assert: bChangeCounter equals: 1.
	
]
