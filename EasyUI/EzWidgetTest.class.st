Class {
	#name : #EzWidgetTest,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'widget',
		'window',
		'allWindows'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzWidgetTest >> morph [
	^widget morph
]

{ #category : #accessing }
EzWidgetTest >> morphAngle [
	^self morph rotationDegrees
]

{ #category : #accessing }
EzWidgetTest >> morphRelativeCenter [
	^self morph center - window rootPosition
]

{ #category : #running }
EzWidgetTest >> newWindow [
	| newWindow |
	newWindow := EzWindow open.
	allWindows add: newWindow.
	^newWindow
]

{ #category : #running }
EzWidgetTest >> setUp [
	super setUp.
	allWindows := Set new.
	window := self newWindow.
	widget := self widgetClass newAt: 0@0.
	window addWidget: widget.
]

{ #category : #running }
EzWidgetTest >> tearDown [
	super tearDown.
	allWindows do: #close.
]

{ #category : #tests }
EzWidgetTest >> testAngle [
	widget angle: 90.
	self assert: self morphAngle equals: 0.
	widget angle: 180.
	self assert: self morphAngle equals: -90.
	widget angle: 270.
	self assert: self morphAngle equals: -180.
	widget angle: 0.
	self assert: self morphAngle equals: 90.
]

{ #category : #tests }
EzWidgetTest >> testOpenInWindowAdaptsPositionRelativeToRootMorph [
	{720@450. 760@490.  680@410} do: [ : aPoint|
		widget := EzEllipseWidget newAt: aPoint.
		widget openInWindow: window.
		self assert: self morphRelativeCenter equals: aPoint
	]
]

{ #category : #tests }
EzWidgetTest >> testOpenWidgetInAnotherWindow [
	| extraWindow |
	extraWindow := self newWindow.
	extraWindow position: (0 to: 800) atRandom @ (0 to: 600) atRandom.
	widget position: 450@250.
	widget openInWindow: extraWindow.
	self assert: window rootMorph submorphs isEmpty.
	self assertCollection: extraWindow rootMorph submorphs hasSameElements: {widget morph}.
	
]

{ #category : #tests }
EzWidgetTest >> testPosition [
	{720@450. 760@490.  680@410} do: [ : aPoint|
		widget position: aPoint.
		self assert: widget position equals: aPoint.
		self assert: self morphRelativeCenter equals: aPoint
	]
]

{ #category : #tests }
EzWidgetTest >> testPositionScaled [
	widget scaleFactor: 2.
	{1@1. 35@64.  680@410} do: [ : aPoint|
		widget position: aPoint.
		self assert: widget position equals: aPoint.
		self assert: self morphRelativeCenter equals: aPoint * 2
	]
]

{ #category : #running }
EzWidgetTest >> widgetClass [
	^EzRectangleWidget
]
