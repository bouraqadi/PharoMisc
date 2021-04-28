"
I am a subject that can have many observers. I automatically generate events  for IV assignments. Observers can subscribe to those events using methods :
- afterChangeOf: ivName do: aBlock
aBlock is valued after executing a method that assigns a new value to the referenced IV.
aBlock can have 0 or 1 argument which is the last value of the changed IV.

- afterChangeDo: aBlock
aBlock is valued after executing a method that performs assignments to one or more IVs.
aBlock can have 0 or 1 argument which is the event materializing the change.
Changed IVs and their last values are stored in the event (see LoIvChangeEvent).
 
Each of the above methods answers an object that is the observer. It can be used to unsubscribe from the subject and stop observing.

    Instance Variables
	dispatcher:		<LoEventDispatcher>


    Implementation Points
Every method with at least one IV assignment is saved in the method dictionary under a selector prefixed with basicSubjectMethod_. Another method using the original selector is generated to call the ""basic"" method and generate the event.
"
Class {
	#name : #LoSubject,
	#superclass : #Object,
	#instVars : [
		'dispatcher'
	],
	#category : #'LightweightObserver-Kernel'
}

{ #category : #'accessing method dictionary' }
LoSubject class >> addAndClassifySelector: selector withMethod: compiledMethod inProtocol: aProtocol [
	(self isBasicMethodSelector: selector)
		ifTrue: [ ^ LoSubjectBasicMethodChangeForbiddenError signal ].
	self
		addObservingHooksFor: selector
		withMethod: compiledMethod
		inProtocol: aProtocol.
	

]

{ #category : #'subject support' }
LoSubject class >> addObservingHooksFor: selector withMethod: compiledMethod inProtocol: aProtocol [
	| ivWriteNodes writtenIvs wrapperMethod basicSelector |
	ivWriteNodes := compiledMethod instanceVariableWriteNodes reject: [: ivNode | ivNode name = self dispatcherIvName].
	basicSelector := self basicMethodSelectorFrom: selector.
	ivWriteNodes ifEmpty: [ 
		super removeSelector: basicSelector.
		^ super addAndClassifySelector: selector withMethod: compiledMethod inProtocol: aProtocol].
	writtenIvs := ivWriteNodes collect: [ :each | each name ].
	wrapperMethod := self newWrapperMethod: selector forWritingIvs: writtenIvs.
	self attachSourceOf: compiledMethod to: wrapperMethod.
	super addAndClassifySelector: selector withMethod: wrapperMethod inProtocol: aProtocol.
	self addSelectorSilently: basicSelector withMethod: compiledMethod. "Avoid having basic method showup in package info"
	self organization 
			classify: basicSelector 
			under: #'private-generated'.
	{wrapperMethod.
	compiledMethod}
		do: [ :each | LoSubjectSupportMethod adoptInstance: each ]
]

{ #category : #'subject support' }
LoSubject class >> attachSourceOf: compiledMethod to: wrapperMethod [
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
LoSubject class >> basicLocalSelectors [
	^super localSelectors
]

{ #category : #'subject support' }
LoSubject class >> basicMethodSelectorFrom: selector [
	^(self basicMethodSelectorPrefix, selector) asSymbol
]

{ #category : #'subject support' }
LoSubject class >> basicMethodSelectorPrefix [
	^#basicSubjectMethod_

]

{ #category : #'subject support' }
LoSubject class >> dispatcherIvName [
	^#dispatcher
]

{ #category : #'class initialization' }
LoSubject class >> initialize [
	self allSubclassesDo: #compileAll
]

{ #category : #'subject support' }
LoSubject class >> isBasicMethodSelector: selector [
	^ selector beginsWith: self basicMethodSelectorPrefix
]

{ #category : #'accessing method dictionary' }
LoSubject class >> localSelectors [
	^self basicLocalSelectors reject: [ : each | 
		each beginsWith: self basicMethodSelectorPrefix ]
]

{ #category : #'subject support' }
LoSubject class >> newWrapperMethod: selector forWritingIvs: writtenIvs [
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
LoSubject class >> newWrapperMethodSource: selector forWriting: writtenIvs [
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
LoSubject class >> recompile: selector from: oldClass [
	| compiledMethod |
	(self isBasicMethodSelector: selector) ifTrue: [ ^self ].
	super recompile: selector from: oldClass.
	compiledMethod := self compiledMethodAt: selector.
	self addAndClassifySelector: selector withMethod: compiledMethod inProtocol: compiledMethod protocol.
]

{ #category : #'subject support' }
LoSubject class >> removeSelector: selector [
	(selector beginsWith: self basicMethodSelectorPrefix) ifTrue: [
		^LoSubjectBasicMethodChangeForbiddenError signal ].
	super removeSelector: selector.
	super removeSelector: (self basicMethodSelectorFrom: selector)
]

{ #category : #'subject support' }
LoSubject class >> subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory [
	| subclass |
	subclass := super subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory.
	subclass compileAll.
	^subclass
]

{ #category : #'subject support' }
LoSubject class >> writeMessage: selector on: supportMethodStream [
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
LoSubject >> afterAddToCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^self 
		afterCollectionAt: ivName 
		triggersEvent: LoSingleElementAddEvent 
		do: [: event | aBlock cull: event element cull: event index]
]

{ #category : #observing }
LoSubject >> afterChangeDo: aBlock [
	^self dispatcher on: LoIvChangeEvent do: [: event | aBlock cull: event]
]

{ #category : #observing }
LoSubject >> afterChangeOf: ivName do: aBlock [
	^self dispatcher 
		on: LoIvChangeEvent 
		do: [: event | event ifChanged: ivName do: aBlock ]
]

{ #category : #observing }
LoSubject >> afterChangeOfCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^self 
		afterCollectionAt: ivName 
		triggersEvent: LoSingleElementChangeEvent 
		do: aBlock
]

{ #category : #observing }
LoSubject >> afterCollectionAt: ivName triggersEvent: collectionEventClass do: aBlock [
	^LoCompositeObserver children: {
		self dispatcher on: collectionEventClass do: aBlock.
		self afterChangeOf: ivName do: [ : newCollection | self makeSubject: newCollection]
	}

]

{ #category : #observing }
LoSubject >> afterRemoveFromCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^self 
		afterCollectionAt: ivName 
		triggersEvent: LoSingleElementRemoveEvent 
		do: [: event | aBlock cull: event element cull: event index]
]

{ #category : #observing }
LoSubject >> afterReplaceInCollection: ivName do: aBlock [
	self makeSubjectIvNamed: ivName.
	^ self
		afterCollectionAt: ivName
		triggersEvent: LoSingleElementReplaceEvent
		do: [ :event | aBlock cull: event key cull: event addedElement cull: event removedElement ]
]

{ #category : #observing }
LoSubject >> dispatch: anEvent [
	self dispatcher dispatch: anEvent
]

{ #category : #accessing }
LoSubject >> dispatcher [
	dispatcher ifNil: [dispatcher := LoEventDispatcher new].
	^dispatcher
]

{ #category : #'observing-private' }
LoSubject >> makeSubject: anObject [
	anObject
		asSubject;
		dispatcher: self dispatcher
]

{ #category : #'observing-private' }
LoSubject >> makeSubjectIvNamed: ivName [
	self makeSubject: (self instVarNamed: ivName)

]

{ #category : #observing }
LoSubject >> unsubscribe: anObserver [
	^self dispatcher unsubscribe: anObserver
]

{ #category : #observing }
LoSubject >> when: eventClass do: actionBlock [
	^self dispatcher on: eventClass do: actionBlock
]
