Class {
	#name : #EzGridExample,
	#superclass : #EzDrawing,
	#category : #'EasyUI-Kernel'
}

{ #category : #examples }
EzGridExample class >> demoWindow [
	<example>
	^self new openWithSpec 
]

{ #category : #examples }
EzGridExample class >> demoWorld [
	<example>
	(self confirm: 'Are you shure to replace the world with this demo?') ifFalse: [^self].
	^self new openWorldWithSpec 
]

{ #category : #initialization }
EzGridExample >> defaultBoardColor [
	^Color red
]

{ #category : #initialization }
EzGridExample >> initialExtent [
	^500@500
]

{ #category : #initialization }
EzGridExample >> initializeWidgets [
	| colors cellIndex rectangleColor rectangle |
	super initializeWidgets.
	colors := {Color yellow. Color black}.
	-4 to: 5 do: [ : y |
		-4 to: 5 do: [ : x |
			cellIndex := x+(y - 1).
			rectangleColor := colors at: (cellIndex % 2) + 1.
			rectangle := self addSquareCenter: (x@y) * 50 - 25 length: 48 fillColor: rectangleColor borderWidth: 1 borderColor: Color transparent.
			view add: rectangle.
			 ] ].

]

{ #category : #api }
EzGridExample >> title [
	^'Easy UI Grid Example'
]
