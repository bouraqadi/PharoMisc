Class {
	#name : #EzRootMorph,
	#superclass : #Morph,
	#instVars : [
		'keyCombination',
		'keyDownHandlersDict',
		'keyUpHandlersDict'
	],
	#category : #'EasyUI-KernelOLD'
}

{ #category : #initialization }
EzRootMorph >> defaultColor [
	^Color green
]

{ #category : #'event handling' }
EzRootMorph >> handlesKeyboard: evt [
	^true
]

{ #category : #initialization }
EzRootMorph >> initialize [ 
	super initialize.
	self clipSubmorphs: true.
	keyDownHandlersDict := Dictionary new.
	keyUpHandlersDict := Dictionary new.

]

{ #category : #accessing }
EzRootMorph >> keyCombination [
	^ keyCombination
]

{ #category : #accessing }
EzRootMorph >> keyCombination: anObject [
	^ keyCombination := anObject
]

{ #category : #'event handling' }
EzRootMorph >> keyStroke: evt [
	keyCombination := evt asKeyCombination.
	self onKeyDown: keyCombination.

]

{ #category : #'event handling' }
EzRootMorph >> keyUp: evt [
	keyCombination ifNil: [ ^self ].
	[self onKeyUp: keyCombination] ensure: [ keyCombination := nil ]
]

{ #category : #'event handling' }
EzRootMorph >> onKeyDown: aKeyCombination [
	keyDownHandlersDict keysAndValuesDo: [ : registredCombination : actionBlock | 
		(registredCombination matchesCompletely: aKeyCombination) ifTrue: [ ^actionBlock value ]  
	]
]

{ #category : #'event handling' }
EzRootMorph >> onKeyDown: charOrKeyCombination do: aBlock [
	keyDownHandlersDict at: charOrKeyCombination asKeyCombination put: aBlock
]

{ #category : #'event handling' }
EzRootMorph >> onKeyUp: aKeyCombination [
	keyUpHandlersDict keysAndValuesDo: [ : registredCombination : actionBlock | 
		(registredCombination matchesCompletely: aKeyCombination) ifTrue: [ ^actionBlock value ]  
	]
]

{ #category : #'event handling' }
EzRootMorph >> onKeyUp: charOrKeyCombination do: aBlock [
	keyUpHandlersDict at: charOrKeyCombination asKeyCombination put: aBlock
]

{ #category : #testing }
EzRootMorph >> takesKeyboardFocus [
	^true
]
