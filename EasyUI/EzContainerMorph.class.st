Class {
	#name : #EzContainerMorph,
	#superclass : #Morph,
	#instVars : [
		'keyCombination',
		'keyDownHandlersDict',
		'keyUpHandlersDict'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #initialization }
EzContainerMorph >> defaultColor [
	^Color green
]

{ #category : #'event handling' }
EzContainerMorph >> handlesKeyboard: evt [
	^true
]

{ #category : #initialization }
EzContainerMorph >> initialize [ 
	super initialize.
	self clipSubmorphs: true.
	keyDownHandlersDict := Dictionary new.
	keyUpHandlersDict := Dictionary new.

]

{ #category : #'event handling' }
EzContainerMorph >> keyStroke: evt [
	keyCombination := evt asKeyCombination.
	self onKeyDown: keyCombination.

]

{ #category : #'event handling' }
EzContainerMorph >> keyUp: evt [
	keyCombination ifNil: [ ^self ].
	[self onKeyUp: keyCombination] ensure: [ keyCombination := nil ]
]

{ #category : #'event handling' }
EzContainerMorph >> onKeyDown: aKeyCombination [
	keyDownHandlersDict keysAndValuesDo: [ : registredCombination : actionBlock | 
		(registredCombination matchesCompletely: aKeyCombination) ifTrue: [ ^actionBlock value ]  
	]
]

{ #category : #'event handling' }
EzContainerMorph >> onKeyDown: charOrKeyCombination do: aBlock [
	keyDownHandlersDict at: charOrKeyCombination asKeyCombination put: aBlock
]

{ #category : #'event handling' }
EzContainerMorph >> onKeyUp: aKeyCombination [
	keyUpHandlersDict keysAndValuesDo: [ : registredCombination : actionBlock | 
		(registredCombination matchesCompletely: aKeyCombination) ifTrue: [ ^actionBlock value ]  
	]
]

{ #category : #'event handling' }
EzContainerMorph >> onKeyUp: charOrKeyCombination do: aBlock [
	keyUpHandlersDict at: charOrKeyCombination asKeyCombination put: aBlock
]

{ #category : #testing }
EzContainerMorph >> takesKeyboardFocus [
	^true
]
