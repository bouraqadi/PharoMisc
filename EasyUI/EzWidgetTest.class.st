Class {
	#name : #EzWidgetTest,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'widget',
		'window',
		'allWindows'
	],
	#category : #'EasyUI-Tests'
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
EzWidgetTest >> morphColor [
	^self morph color
]

{ #category : #accessing }
EzWidgetTest >> morphRelativeCenter [
	^self morph center - window referencePosition
]

{ #category : #running }
EzWidgetTest >> newGridWindow [
	^self newWindow: EzGridWindow
]

{ #category : #running }
EzWidgetTest >> newWindow [
	^self newWindow: EzWindow
]

{ #category : #running }
EzWidgetTest >> newWindow: windowClass [
	| newWindow |
	newWindow := windowClass open.
	allWindows add: newWindow.
	^newWindow
]

{ #category : #running }
EzWidgetTest >> setUp [
	super setUp.
	allWindows := Set new.
	window := self newWindow.
	widget := self widgetClass new.
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
EzWidgetTest >> testColor [
	{Color red. Color green. Color blue. Color orange. Color black } do: [ : aColor |
		widget color: aColor.
		self assert: widget color equals: aColor.
		self assert: self morphColor equals: aColor.
	]

]

{ #category : #tests }
EzWidgetTest >> testExtent [
	| expectedPosition |
	expectedPosition := widget position.
	{ 20@30. 40@50. 100@100 } do: [ : expectedExtent |
		widget extent: expectedExtent.
		self assert: widget extent equals: expectedExtent.
		self assert: widget basicMorph extent equals: expectedExtent.
		self assert: widget position equals: expectedPosition.
	]

]

{ #category : #tests }
EzWidgetTest >> testOpenInWindowAdaptsPositionRelativeToRootMorph [
	{720@450. 760@490.  680@410} do: [ : aPoint|
		widget := EzEllipseWidget new.
		window addWidget: widget at: aPoint.
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
EzWidgetTest >> testPositionAdaptsToPixelsPerPointRatio [
	window := self newGridWindow.
	widget openInWindow: window.
	window pixelsPerPoint: 2.
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
