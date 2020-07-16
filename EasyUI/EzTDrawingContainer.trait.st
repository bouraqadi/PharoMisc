Trait {
	#name : #EzTDrawingContainer,
	#instVars : [
		'drawings',
		'backgroundPaint',
		'drawingAreaExtent'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #adding }
EzTDrawingContainer >> add: aDrawing [
	(self drawings includes: aDrawing)
		ifTrue: [ ^ self ].
	self basicAdd: aDrawing.
	self redraw.


]

{ #category : #adding }
EzTDrawingContainer >> addAll: newDawings [
	newDawings do: [ : each | self basicAdd: each ].
	self redraw.
]

{ #category : #adding }
EzTDrawingContainer >> basicAdd: aDrawing [
	drawings add: aDrawing.
	aDrawing container: self.
	
]

{ #category : #adding }
EzTDrawingContainer >> basicRemove: aDrawing [
	drawings remove: aDrawing.
	aDrawing container: nil.

]

{ #category : #rendering }
EzTDrawingContainer >> drawOn: canvas [
	drawings do: [ :each | each renderOn: canvas]
]

{ #category : #accessing }
EzTDrawingContainer >> drawings [
	^drawings
]

{ #category : #initialization }
EzTDrawingContainer >> initDrawings [
	drawings := OrderedCollection new.
]

{ #category : #rendering }
EzTDrawingContainer >> moveToBack: aDrawing [
	drawings remove: aDrawing.
	drawings addFirst: aDrawing.
	self redraw.
]

{ #category : #rendering }
EzTDrawingContainer >> moveToFront: aDrawing [
	drawings remove: aDrawing.
	drawings addLast: aDrawing.
	self redraw.
]

{ #category : #adding }
EzTDrawingContainer >> remove: aDrawing [
	(self drawings includes: aDrawing)
		ifFalse: [ ^ self ].
	self basicRemove: aDrawing.
	self redraw.

]
