Class {
	#name : #EzDrawingBoardPresenter,
	#superclass : #ImagePresenter,
	#instVars : [
		'backgroundColor'
	],
	#category : #'EasyUI-SpecDemo'
}

{ #category : #accessing }
EzDrawingBoardPresenter >> backgroundColor [
	^backgroundColor
]

{ #category : #accessing }
EzDrawingBoardPresenter >> backgroundColor: aColor [ 
	backgroundColor := aColor 
]

{ #category : #accessing }
EzDrawingBoardPresenter >> canvas [
	^self image getCanvas
]

{ #category : #initialization }
EzDrawingBoardPresenter >> defaultBackgroundColor [
	^Color white
]

{ #category : #initialization }
EzDrawingBoardPresenter >> defaultExtent [
	^400@300
]

{ #category : #drawing }
EzDrawingBoardPresenter >> delete: aDrawing [
	self canvas fillRectangle: aDrawing bounds color: self backgroundColor
]

{ #category : #api }
EzDrawingBoardPresenter >> extent: newExtent [
	self image: (Form extent: newExtent depth: 8).
	self fillColor: self backgroundColor.
]

{ #category : #accessing }
EzDrawingBoardPresenter >> fillColor: aColor [ 
	self canvas fillColor: aColor
]

{ #category : #initialization }
EzDrawingBoardPresenter >> initialize [
	super initialize.
	self backgroundColor: self defaultBackgroundColor.
	self extent: self defaultExtent.
]

{ #category : #drawing }
EzDrawingBoardPresenter >> show: aDrawing [
	self image 
		copyBits: aDrawing currentForm 
		at: aDrawing position 
		translucent: 255
	
]
