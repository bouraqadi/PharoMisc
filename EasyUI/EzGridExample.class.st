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
EzGridExample >> defaultBoardExtent [
	^500@500
]

{ #category : #initialization }
EzGridExample >> initializeWidgets [
	| colors cellIndex rectangleColor rectangle |
	super initializeWidgets.
	colors := {Color yellow. Color black}.
	0 to: 9 do: [ : y |
		0 to: 9 do: [ : x |
			cellIndex := x+(y - 1).
			rectangleColor := colors at: (cellIndex % 2) + 1.
			rectangle := view addSquareOrigine: (x@y) * 50 + 1 length: 48 fillColor: rectangleColor borderWidth: 1 borderColor: Color transparent.
			view add: rectangle.
			 ] ].

]

{ #category : #accessing }
EzGridExample >> isWindowResizable [
	^false
]

{ #category : #api }
EzGridExample >> title [
	^'Easy UI Grid Example'
]
