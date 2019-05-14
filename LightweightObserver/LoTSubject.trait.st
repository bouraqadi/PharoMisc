Trait {
	#name : #LoTSubject,
	#category : #'LightweightObserver-Kernel'
}

{ #category : #'accessing method dictionary' }
LoTSubject classSide >> addAndClassifySelector: selector withMethod: compiledMethod inProtocol: aProtocol [
	(self isBasicMethodSelector: selector)
		ifTrue: [ ^ LoSubjectBasicMethodChangeForbiddenError signal ].
	self
		addObservingHooksFor: selector
		withMethod: compiledMethod
		inProtocol: aProtocol.
	

]

{ #category : #'subject support' }
LoTSubject classSide >> addObservingHooksFor: selector withMethod: compiledMethod inProtocol: aProtocol [
	| ivWriteNodes writtenIvs wrapperMethod basicSelector |
	ivWriteNodes := compiledMethod instanceVariableWriteNodes reject: [: ivNode | ivNode name = self dispatcherIvName].
	basicSelector := self basicMethodSelectorFrom: selector.
	ivWriteNodes ifEmpty: [ 
		super removeSelector: basicSelector.
		^ self basicAddAndClassifySelector: selector withMethod: compiledMethod inProtocol: aProtocol].
	writtenIvs := ivWriteNodes collect: [ :each | each name ].
	wrapperMethod := self newWrapperMethod: selector forWritingIvs: writtenIvs.
	self attachSourceOf: compiledMethod to: wrapperMethod.
	self basicAddAndClassifySelector: selector withMethod: wrapperMethod inProtocol: aProtocol.
	self basicAddAndClassifySelector: basicSelector withMethod: compiledMethod inProtocol: #'private-generated'.
	{wrapperMethod.
	compiledMethod}
		do: [ :each | LoSubjectSupportMethod adoptInstance: each ]
]

{ #category : #'subject support' }
LoTSubject classSide >> attachSourceOf: compiledMethod to: wrapperMethod [
	wrapperMethod
		putSource: compiledMethod sourceCode
		withPreamble: [ :f | 
			f
				cr;
				nextPut: $!;
				nextChunkPut: 'Subject wrapper method';
				cr ]
]

{ #category : #'accessing method dictionary' }
LoTSubject classSide >> basicAddAndClassifySelector: selector withMethod: compiledMethod inProtocol: aCategory [
	
	"When a new methods is added, I add it to the localMethodDict and also propagate the changes to my users"
	self localMethodDict at: selector put: compiledMethod.
	
	super
		addAndClassifySelector: selector
		withMethod: compiledMethod
		inProtocol: aCategory.

	TraitChange addSelector: selector on: self.	
]

{ #category : #'subject support' }
LoTSubject classSide >> basicMethodSelectorFrom: selector [
	^(self basicMethodSelectorPrefix, selector) asSymbol
]

{ #category : #'subject support' }
LoTSubject classSide >> basicMethodSelectorPrefix [
	^#basicSubjectMethod_

]

{ #category : #removing }
LoTSubject classSide >> basicRemoveSelector: aSelector [

	"When a selector is removed it should be notified to my users.
	Check the class TraitChange for more details"
	super removeSelector: aSelector.
	self localMethodDict removeKey: aSelector ifAbsent: [  ].

	TraitChange removeSelector: aSelector on: self.
]

{ #category : #'subject support' }
LoTSubject classSide >> dispatcherIvName [
	^#dispatcher
]

{ #category : #'subject support' }
LoTSubject classSide >> isBasicMethodSelector: selector [
	^ selector beginsWith: self basicMethodSelectorPrefix
]

{ #category : #'subject support' }
LoTSubject classSide >> newWrapperMethod: selector forWritingIvs: writtenIvs [
	| wrapperMethodSource wrapperMethod |
	wrapperMethodSource := self
		newWrapperMethodSource: selector
		forWriting: writtenIvs.
	wrapperMethod := self compiler
		source: wrapperMethodSource;
		failBlock: [ ^ nil ];
		compile.
	^wrapperMethod
]

{ #category : #'subject support' }
LoTSubject classSide >> newWrapperMethodSource: selector forWriting: writtenIvs [
	| wrapperMethodStream |
	wrapperMethodStream := String new writeStream.
	self writeMessage: selector on: wrapperMethodStream.
	wrapperMethodStream
		cr;
		nextPutAll: '|result event|';
		cr;
		nextPutAll: 'result := self '.
	self writeMessage: (self basicMethodSelectorFrom: selector) on: wrapperMethodStream.
	wrapperMethodStream
		nextPut: $.;
		cr;
		nextPutAll: 'dispatcher ifNil: [^result].';
		cr;
		nextPutAll: 'event := ';
		nextPutAll: LoIvChangeEvent name;
		nextPutAll: ' new.'.
	writtenIvs
		do: [ :ivName | 
			wrapperMethodStream
				cr;
				nextPutAll: 'event addIv: #';
				nextPutAll: ivName;
				nextPutAll: ' newValue: ';
				nextPutAll: ivName;
				nextPut: $. ].
	wrapperMethodStream
		cr;
		nextPutAll: 'dispatcher dispatch: event.';
		cr;
		nextPutAll: '^result'.
	^ wrapperMethodStream contents
]

{ #category : #'subject support' }
LoTSubject classSide >> recompile: selector from: oldClass [
	| compiledMethod |
	(self isBasicMethodSelector: selector) ifTrue: [ ^self ].
	super recompile: selector from: oldClass.
	compiledMethod := self compiledMethodAt: selector.
	self addAndClassifySelector: selector withMethod: compiledMethod inProtocol: compiledMethod protocol.
]

{ #category : #'subject support' }
LoTSubject classSide >> removeSelector: selector [
	(selector beginsWith: self basicMethodSelectorPrefix) ifTrue: [
		^LoSubjectBasicMethodChangeForbiddenError signal ].
	self basicRemoveSelector: selector.
	self basicRemoveSelector: (self basicMethodSelectorFrom: selector)
]

{ #category : #'subject support' }
LoTSubject classSide >> subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory [
	| subclass |
	subclass := super subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory.
	subclass compileAll.
	^subclass
]

{ #category : #'subject support' }
LoTSubject classSide >> writeMessage: selector on: supportMethodStream [
	selector isKeyword ifFalse: [^supportMethodStream nextPutAll: selector].
	selector keywords
		withIndexDo: [ :keyword :argIndex | 
			supportMethodStream
				nextPutAll: keyword;
				space;
				nextPut: $a;
				print: argIndex;
				space ]
]

{ #category : #observing }
LoTSubject >> afterAddToCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^self 
		afterCollectionAt: ivName 
		triggersEvent: LoSingleElementAddEvent 
		do: [: event | aBlock cull: event element cull: event index]
]

{ #category : #observing }
LoTSubject >> afterChangeDo: aBlock [
	^self dispatcher on: LoIvChangeEvent do: [: event | aBlock cull: event]
]

{ #category : #observing }
LoTSubject >> afterChangeOf: ivName do: aBlock [
	^self dispatcher 
		on: LoIvChangeEvent 
		do: [: event | event ifChanged: ivName do: aBlock ]
]

{ #category : #observing }
LoTSubject >> afterChangeOfCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^self 
		afterCollectionAt: ivName 
		triggersEvent: LoSingleElementChangeEvent 
		do: aBlock
]

{ #category : #observing }
LoTSubject >> afterCollectionAt: ivName triggersEvent: collectionEventClass do: aBlock [
	^LoCompositeObserver children: {
		self dispatcher on: collectionEventClass do: aBlock.
		self afterChangeOf: ivName do: [ : newCollection | self makeSubject: newCollection]
	}

]

{ #category : #observing }
LoTSubject >> afterRemoveFromCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^self 
		afterCollectionAt: ivName 
		triggersEvent: LoSingleElementRemoveEvent 
		do: [: event | aBlock cull: event element cull: event index]
]

{ #category : #observing }
LoTSubject >> afterReplaceInCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^ self
		afterCollectionAt: ivName
		triggersEvent: LoSingleElementReplaceEvent
		do: [ :event | aBlock cull: event key cull: event addedElement cull: event removedElement ]
]

{ #category : #observing }
LoTSubject >> dispatch: anEvent [
	self dispatcher dispatch: anEvent
]

{ #category : #accessing }
LoTSubject >> dispatcher [
	self explicitRequirement
]

{ #category : #'observing-private' }
LoTSubject >> makeSubject: anObject [
	anObject
		asSubject;
		dispatcher: self dispatcher
]

{ #category : #'observing-private' }
LoTSubject >> makeSubjectIvNamed: ivName [
	self makeSubject: (self instVarNamed: ivName)

]

{ #category : #observing }
LoTSubject >> on: eventClass do: actionBlock [
	^self dispatcher on: eventClass do: actionBlock
]

{ #category : #observing }
LoTSubject >> unsubscribe: anObserver [
	^self dispatcher unsubscribe: anObserver
]
