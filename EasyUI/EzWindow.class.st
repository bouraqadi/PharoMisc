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

{ #category : #private }
EzWindow >> addWidgetMorph: aMorph [
	rootMorph addMorph: aMorph
]

{ #category : #initialization }
EzWindow >> defaultBounds [
	^0@0 extent: self initialExtent
]

{ #category : #initialization }
EzWindow >> defaultLabel [
	^''
]

{ #category : #initialization }
EzWindow >> initialExtent [
	^(0 @ self labelHeight) + self rootMorphDefaultExtent
]

{ #category : #initialization }
EzWindow >> initialize [
	super initialize.
	rootMorph := self newRootMorph.
	self addMorph: rootMorph frame: (0@0 extent: 1@1).
	self label: self defaultLabel.
	self bounds: self defaultBounds.
]

{ #category : #accessing }
EzWindow >> label: newLabel [
	self setLabel: newLabel
]

{ #category : #initialization }
EzWindow >> newRootMorph [
	| morph |
	morph := self rootMorphClass new.
	morph 
		extent: self rootMorphDefaultExtent;
		color: self rootMorphDefaultColor;
		clipSubmorphs: true.
	^morph
]

{ #category : #accessing }
EzWindow >> rootMorph [
	^rootMorph
]

{ #category : #initialization }
EzWindow >> rootMorphClass [
	^Morph
]

{ #category : #initialization }
EzWindow >> rootMorphDefaultColor [
	^Color white
]

{ #category : #initialization }
EzWindow >> rootMorphDefaultExtent [
	^800@600
]

{ #category : #accessing }
EzWindow >> rootPosition [
	^rootMorph position
]
