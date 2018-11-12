Class {
	#name : #EzWidget,
	#superclass : #Object,
	#instVars : [
		'morph',
		'transform',
		'angle',
		'scaleFactor',
		'window'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzWidget class >> newAt: aPoint [
	^self new
		position: aPoint;
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

{ #category : #initialization }
EzWidget >> defaultAngle [
	^0
]

{ #category : #initialization }
EzWidget >> defaultColor [
	self subclassResponsibility
]

{ #category : #initialization }
EzWidget >> defaultScaleFactor [
	^1
]

{ #category : #displaying }
EzWidget >> delete [
	self morph delete.
]

{ #category : #initialization }
EzWidget >> finalize [
	self delete
]

{ #category : #initialization }
EzWidget >> initialize [
	super initialize.
	self angle: self defaultAngle.
	self scaleFactor: self defaultScaleFactor.
	morph := self morphClass new.
	morph extent: self morphExtent.
	morph color: self defaultColor.

	
]

{ #category : #accessing }
EzWidget >> morph [
	^transform ifNil: [ morph ]
]

{ #category : #initialization }
EzWidget >> morphClass [
	self subclassResponsibility
]

{ #category : #initialization }
EzWidget >> morphExtent [
	^40@40
]

{ #category : #displaying }
EzWidget >> openInWindow: aWindow [
	| currentPosition |
	self delete.
	currentPosition := self position.
	window := aWindow.
	window addWidgetMorph: morph.
	transform := morph addFlexShell.
	transform rotationDegrees: self angle.
	self position: currentPosition.

]

{ #category : #accessing }
EzWidget >> position [
	^(self morph center - self windowPosition) / self scaleFactor
]

{ #category : #accessing }
EzWidget >> position: newCenter [
	self morph center: self windowPosition + (newCenter * self scaleFactor)
]

{ #category : #accessing }
EzWidget >> scaleFactor [
	^scaleFactor
]

{ #category : #accessing }
EzWidget >> scaleFactor: aFactor [
	scaleFactor := aFactor
]

{ #category : #accessing }
EzWidget >> window [
	^window
]

{ #category : #accessing }
EzWidget >> windowPosition [
	self window ifNil: [ ^0@0 ].
	^self window rootPosition.
]
