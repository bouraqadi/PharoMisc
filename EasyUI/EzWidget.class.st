"
I am a graphical element displayed on EzWindow.

My position is the point corresponding to my center relative to the upper left corner of my window.

I can rotate. I express angles in degrees between -180 and 180.

See class EzWindowWithWigetsExample
"
Class {
	#name : #EzWidget,
	#superclass : #Object,
	#instVars : [
		'morph',
		'transform',
		'angle',
		'window'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzWidget class >> newExtent: aPoint [
	^self new
		extent: aPoint;
		yourself
]

{ #category : #accessing }
EzWidget >> angle [
	^angle
]

{ #category : #accessing }
EzWidget >> angle: degrees [
	angle := (degrees - 90) negated.
	transform ifNil: [ ^self ].
	transform rotationDegrees: angle
	
]

{ #category : #private }
EzWidget >> basicMorph [
	^morph
]

{ #category : #accessing }
EzWidget >> color [
	^self morph color
]

{ #category : #accessing }
EzWidget >> color: aColor [ 
	self morph color: aColor.
]

{ #category : #initialization }
EzWidget >> defaultAngle [
	^0
]

{ #category : #initialization }
EzWidget >> defaultColor [
	self subclassResponsibility
]

{ #category : #initialization }
EzWidget >> defaultExtent [
	^40@40
]

{ #category : #displaying }
EzWidget >> delete [
	self morph delete.
]

{ #category : #accessing }
EzWidget >> extent [
	^morph extent
]

{ #category : #accessing }
EzWidget >> extent: aPoint [
	self withFixedPositionDo: [morph extent: aPoint]
]

{ #category : #initialization }
EzWidget >> finalize [
	self delete
]

{ #category : #initialization }
EzWidget >> initialize [
	super initialize.
	self angle: self defaultAngle.
	morph := self morphClass new.
	morph extent: self defaultExtent.
	morph color: self defaultColor.

	
]

{ #category : #private }
EzWidget >> morph [
	^transform ifNil: [ morph ]
]

{ #category : #initialization }
EzWidget >> morphClass [
	self subclassResponsibility
]

{ #category : #displaying }
EzWidget >> openInWindow: aWindow [
	self withFixedPositionDo: [ 
			self delete.
			window := aWindow.
			window addWidgetMorph: morph.
			transform := morph addFlexShell.
			transform rotationDegrees: self angle ]
]

{ #category : #accessing }
EzWidget >> pixelsPerPoint [
	self window ifNil: [ ^1 ].
	^self window pixelsPerPoint
]

{ #category : #accessing }
EzWidget >> position [
	^(self morph center - self referencePosition) / self pixelsPerPoint
]

{ #category : #accessing }
EzWidget >> position: newCenter [
	self morph center: self referencePosition + (newCenter * self pixelsPerPoint)
]

{ #category : #accessing }
EzWidget >> referencePosition [
	self window ifNil: [ ^0@0 ].
	^self window referencePosition.
]

{ #category : #accessing }
EzWidget >> window [
	^window
]

{ #category : #private }
EzWidget >> withFixedPositionDo: aBlock [
	| currentPosition |
	currentPosition := self position.
	aBlock ensure: [ self position: currentPosition ]
]
