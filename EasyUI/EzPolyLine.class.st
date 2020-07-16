Class {
	#name : #EzPolyLine,
	#superclass : #EzDrawing,
	#instVars : [
		'width',
		'color',
		'extents'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzPolyLine class >> from: startPoint to: endPoint [
	^self vertices: { startPoint. endPoint }
]

{ #category : #'instance creation' }
EzPolyLine class >> vertices: vertices [
	^self new
		vertices: vertices;
		yourself
]

{ #category : #accessing }
EzPolyLine >> color [
	^ color
]

{ #category : #accessing }
EzPolyLine >> color: anObject [
	color := anObject.
	self redraw.
]

{ #category : #initialization }
EzPolyLine >> defaultColor [
	^Color black
]

{ #category : #initialization }
EzPolyLine >> defaultWidth [
	^3
]

{ #category : #rendering }
EzPolyLine >> drawOn: canvas [
	(canvas setStrokePaint: self color) width: self width.
	canvas draw.

]

{ #category : #accessing }
EzPolyLine >> extents [
	^ extents
]

{ #category : #accessing }
EzPolyLine >> extents: anObject [
	extents := anObject.
	"Shape is recreated only if its nil"
	self shape: nil.

]

{ #category : #initialization }
EzPolyLine >> initialize [
	super initialize.
	self color: self defaultColor.
	self width: self defaultWidth.
	extents := OrderedCollection new. 
]

{ #category : #rendering }
EzPolyLine >> newShapeForCanvas: canvas [
	^canvas createPath: [ : path | 
		path relative.
		self extents do: [ : each |  
			path lineTo: each].
	].

]

{ #category : #rendering }
EzPolyLine >> shapeForCanvas: canvas [
	^shape ifNil: [ shape := self newShapeForCanvas: canvas ]
]

{ #category : #initialization }
EzPolyLine >> vertices: points [
	| newExtents |
	origin := points first.
	newExtents := points allButFirst collect: [ : each | each - self origin ].
	self extents: newExtents.
]

{ #category : #accessing }
EzPolyLine >> width [
	^ width
]

{ #category : #accessing }
EzPolyLine >> width: anObject [
	width := anObject.
	self redraw.
]
