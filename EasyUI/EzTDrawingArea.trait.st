Trait {
	#name : #EzTDrawingArea,
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzTDrawingArea >> drawings [
	self explicitRequirement
]

{ #category : #drawing }
EzTDrawingArea >> moveToBack: aDrawing [
	self drawings 
		remove: aDrawing ifAbsent: [];
		addFirst: aDrawing.

]

{ #category : #drawing }
EzTDrawingArea >> moveToFront: aDrawing [
	self drawings 
		remove: aDrawing ifAbsent: [];
		addLast: aDrawing.

]

{ #category : #drawing }
EzTDrawingArea >> remove: aDrawing [
	self drawings remove: aDrawing ifAbsent: [^self].	

]
