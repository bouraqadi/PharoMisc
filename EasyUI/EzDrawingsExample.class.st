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
	| colors widgetDiameter widgetRadius robot rectangle circle |
	super initializeWidgets.
	colors := { Color red. Color green. Color cyan. Color magenta. Color orange }.
	widgetDiameter := 40.
	widgetRadius := widgetDiameter / 2.
	(60 to: 320 by: 60) withIndexDo: [ : y : index | 
		robot := board addRobotAt: 100@y radius: widgetRadius fillColor: Color yellow borderWidth: 4 borderColor: Color red.	
"		robot angle: (index - 1) * 45."
		rectangle := board addSquareOrigine: 200@(y - widgetRadius) length: widgetDiameter fillColor: Color black borderWidth: 1 borderColor: colors atRandom.
"		rectangle angle: (index - 1) * 45."
		circle := board addCircleCenter: 300@y radius: widgetRadius fillColor: colors atRandom borderWidth: 1 borderColor: Color black.
	].
	
]

{ #category : #api }
EzDrawingsExample >> title [
	^'Easy UI Drawing Examples'
]
