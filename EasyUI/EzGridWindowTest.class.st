Class {
	#name : #EzGridWindowTest,
	#superclass : #EzWindowTest,
	#category : #'EasyUI-Tests'
}

{ #category : #tests }
EzGridWindowTest >> setUp [
	super setUp.
	self setWindowRootMorphPositionX0Y0

]

{ #category : #tests }
EzGridWindowTest >> setWindowRootMorphPositionX0Y0 [
	window position: 0@0.
	window position: window rootMorph position negated.

]

{ #category : #tests }
EzGridWindowTest >> testWidgetsPositions [
	| widget |
	widget := EzRectangleWidget new.
	widget extent: 50@50.
	window pixelsPerPoint: 50.
	window addWidget: widget.
	1 to: 10 do: [ : xy |
		widget position: xy@xy.
		self assert: widget position equals: xy@xy.
		self assert: widget morph center equals: (50@50) * xy - 25]
]

{ #category : #running }
EzGridWindowTest >> windowClass [
	^EzGridWindow
]
