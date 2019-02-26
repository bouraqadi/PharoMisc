Class {
	#name : #EzDrawingsExample,
	#superclass : #EzDrawingApp,
	#category : #'EasyUI-Kernel'
}

{ #category : #examples }
EzDrawingsExample class >> demoWindow [
	<example>
	^self new openWithSpec 
]

{ #category : #examples }
EzDrawingsExample class >> demoWorld [
	<example>
	(self confirm: 'Are you shure to replace the world with this demo?') ifFalse: [^self].
	^self new openWorldWithSpec 
]

{ #category : #initialization }
EzDrawingsExample >> defaultBoardColor [
	^Color paleBlue
]

{ #category : #initialization }
EzDrawingsExample >> defaultBoardExtent [
	^500@400
]

{ #category : #initialization }
EzDrawingsExample >> initializeWidgets [
	| colors widgetLength robot rectangle circle |
	super initializeWidgets.
	colors := { Color red. Color green. Color cyan. Color magenta. Color orange }.
	widgetLength := 41.
	(60 to: 320 by: 60) withIndexDo: [ : y : index | 
		robot := board newCircleDiameter: widgetLength fillColor: Color blue frameColor: Color gray arrowColor: Color red.	
		robot angle: (index - 1) * 45.
		robot center: 100@y.
		board add: robot.
		rectangle := board newSquareLength: widgetLength fillColor: Color black.
		rectangle angle: (index - 1) * 45.
		rectangle center: 200@y.
		board add: rectangle.
		circle := board newCircleDiameter: widgetLength fillColor: colors atRandom.
		circle center: 300@y.
		board add: circle.
	].
	
]

{ #category : #api }
EzDrawingsExample >> title [
	^'Easy UI Drawing Examples'
]
