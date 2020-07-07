Class {
	#name : #EzDrawing,
	#superclass : #Object,
	#instVars : [
		'shape',
		'fillColor',
		'borderColor',
		'borderWidth',
		'position',
		'angle'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzDrawing >> angle [
	^angle
]

{ #category : #drawing }
EzDrawing >> angle: degrees [
	angle := degrees
]

{ #category : #drawing }
EzDrawing >> drawOn: canvas [
	canvas pathTransform restoreAfter: [
		canvas pathTransform translateX: position x Y: position y.
		canvas pathTransform rotateByDegrees: angle.
		canvas setShape: shape.
		canvas setPaint: fillColor.
		canvas draw.
		(canvas setStrokePaint: borderColor) width: borderWidth.
		canvas draw.]


]

{ #category : #initialization }
EzDrawing >> initialize [
	super initialize.
	fillColor := Color red.
	borderColor := Color blue.
	borderWidth := 3.
	shape := 0@0 corner: 50@50.
	angle := 0.
	position := 100@100
]

{ #category : #accessing }
EzDrawing >> position [
	^position
]

{ #category : #drawing }
EzDrawing >> position: aPoint [
	position := aPoint
]
