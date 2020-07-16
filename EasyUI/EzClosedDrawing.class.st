Class {
	#name : #EzClosedDrawing,
	#superclass : #EzAtomicDrawing,
	#instVars : [
		'fillColor',
		'borderColor',
		'borderWidth'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzClosedDrawing >> borderColor [
	^ borderColor
]

{ #category : #accessing }
EzClosedDrawing >> borderColor: anObject [
	borderColor := anObject.
	self redraw.
]

{ #category : #accessing }
EzClosedDrawing >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
EzClosedDrawing >> borderWidth: anObject [
	borderWidth := anObject.
	self redraw.
]

{ #category : #initialization }
EzClosedDrawing >> defaultBorderColor [
	^ Color black
]

{ #category : #initialization }
EzClosedDrawing >> defaultBorderWidth [
	^ 3
]

{ #category : #initialization }
EzClosedDrawing >> defaultFillColor [
	^ Color green
]

{ #category : #rendering }
EzClosedDrawing >> drawOn: canvas [
	super drawOn: canvas.
	canvas setPaint: self fillColor.
	canvas draw.
	(canvas setStrokePaint: self borderColor) width: self borderWidth.
	canvas draw.


]

{ #category : #accessing }
EzClosedDrawing >> fillColor [
	^ fillColor
]

{ #category : #accessing }
EzClosedDrawing >> fillColor: anObject [
	fillColor := anObject.
	self redraw.
]

{ #category : #initialization }
EzClosedDrawing >> initialize [
	super initialize.
	fillColor := self defaultFillColor.
	borderColor := self defaultBorderColor.
	borderWidth := self defaultBorderWidth.

]
