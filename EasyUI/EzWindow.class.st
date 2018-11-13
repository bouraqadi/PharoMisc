"
I am a window. 

You can create and open one with a single message.

See class EzWindowWithWigetsExample class>>#windowExample


"
Class {
	#name : #EzWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'rootMorph'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzWindow class >> open [
	^self new
		openInWorld;
		yourself
]

{ #category : #'instance creation' }
EzWindow class >> openLabelled: aString [
	^(self labelled: aString)
		openInWorld;
		yourself
]

{ #category : #'handling widgets' }
EzWindow >> addWidget: aWidget [
	aWidget openInWindow: self
]

{ #category : #'handling widgets' }
EzWindow >> addWidget: aWidget at: aPoint [
	aWidget position: aPoint.
	aWidget openInWindow: self
]

{ #category : #private }
EzWindow >> addWidgetMorph: aMorph [
	rootMorph addMorph: aMorph
]

{ #category : #accessing }
EzWindow >> backgroundColor [
	^self rootMorph color
]

{ #category : #accessing }
EzWindow >> backgroundColor: aColor [ 
	self rootMorph color: aColor
]

{ #category : #settings }
EzWindow >> beFixedSize [
	self isResizeable ifFalse: [ ^self ].
	self removeExpandBox.
	self isResizeable: false
]

{ #category : #settings }
EzWindow >> beResizable [
	self isResizeable ifTrue: [ ^self ].
	self addExpandBox.
	self isResizeable: true
]

{ #category : #accessing }
EzWindow >> contentExtent [
	^self rootMorph extent
]

{ #category : #accessing }
EzWindow >> contentExtent: newContentExtent [
	| deltaExtent |
	deltaExtent := newContentExtent - rootMorph extent.
	self extent: self extent + deltaExtent
]

{ #category : #initialization }
EzWindow >> defaultBackgroundColor [
	^Color white
]

{ #category : #initialization }
EzWindow >> defaultContentExtent [
	^400@300
]

{ #category : #initialization }
EzWindow >> defaultLabel [
	^''
]

{ #category : #initialization }
EzWindow >> initialize [
	super initialize.
	rootMorph := self newRootMorph.
	self addMorph: rootMorph frame: (0@0 extent: 1@1).
	self backgroundColor: self defaultBackgroundColor.
	self label: self defaultLabel.
	self contentExtent: self defaultContentExtent.

]

{ #category : #accessing }
EzWindow >> label: newLabel [
	self setLabel: newLabel
]

{ #category : #initialization }
EzWindow >> newRootMorph [
	^self rootMorphClass new
		clipSubmorphs: true;
		yourself
]

{ #category : #accessing }
EzWindow >> pixelsPerPoint [
	^1
]

{ #category : #accessing }
EzWindow >> referencePosition [
	^rootMorph position
]

{ #category : #private }
EzWindow >> rootMorph [
	^rootMorph
]

{ #category : #initialization }
EzWindow >> rootMorphClass [
	^Morph
]
