Class {
	#name : #EzGridExample,
	#superclass : #EzDrawingApp,
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
	1 to: 10 do: [ : y |
		1 to: 10 do: [ : x |
			cellIndex := x+(y - 1).
			rectangleColor := colors at: (cellIndex % 2) + 1.
			rectangle := board newSquareLength: 48 fillColor: rectangleColor.
			rectangle center: (x@y) * 50 - 25.
			board add: rectangle.
			 ] ].

]

{ #category : #api }
EzGridExample >> title [
	^'Easy UI Grid Example'
]
