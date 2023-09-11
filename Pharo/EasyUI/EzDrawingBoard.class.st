Class {
	#name : #EzDrawingBoard,
	#superclass : #SpAthensPresenter,
	#traits : 'EzTDrawingContainer',
	#classTraits : 'EzTDrawingContainer classTrait',
	#instVars : [
		'backgroundPaint'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzDrawingBoard class >> surfaceExtent: extent [
	^self new
		surfaceExtent: extent;
		yourself
]

{ #category : #specs }
EzDrawingBoard class >> title [
	^'Easy UI Drawing Board'
]

{ #category : #accessing }
EzDrawingBoard >> backgroundPaint [
	^ backgroundPaint
]

{ #category : #accessing }
EzDrawingBoard >> backgroundPaint: anObject [
	backgroundPaint := anObject
]

{ #category : #initialization }
EzDrawingBoard >> defaultBackgroundPaint [
	^Color white
]

{ #category : #initialization }
EzDrawingBoard >> defaultSurfaceExtent [
	^800@600
]

{ #category : #accessing }
EzDrawingBoard >> height [
	^self surfaceExtent y
]

{ #category : #initialization }
EzDrawingBoard >> initialExtent [
	^surfaceExtent + self windowDeltaExtent

]

{ #category : #initialization }
EzDrawingBoard >> initialize [
	super initialize.
	self initDrawings.
	self surfaceExtent: self defaultSurfaceExtent.
	self backgroundPaint: self defaultBackgroundPaint.
	self drawBlock: [ :canvas | self renderOn: canvas ]
]

{ #category : #rendering }
EzDrawingBoard >> redraw [
	self adapter changed
]

{ #category : #rendering }
EzDrawingBoard >> renderOn: canvas [
	canvas setShape: (0 @ 0 corner: self surfaceExtent).
	canvas setPaint: self backgroundPaint.
	canvas draw.
	self drawOn: canvas
]

{ #category : #accessing }
EzDrawingBoard >> width [
	^self surfaceExtent x
]

{ #category : #initialization }
EzDrawingBoard >> windowBorderWidth [
	^5
]

{ #category : #initialization }
EzDrawingBoard >> windowDeltaExtent [
	^(self windowBorderWidth * 2)@(self windowBorderWidth + self windowTopHeight)
]

{ #category : #initialization }
EzDrawingBoard >> windowTopHeight [
	^28
]
