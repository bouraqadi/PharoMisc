Class {
	#name : #EzDrawingsExample,
	#superclass : #EzDrawing,
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
EzDrawingsExample >> initialExtent [
	^500@400
]

{ #category : #initialization }
EzDrawingsExample >> initializeWidgets [
	| colors widgetDiameter widgetRadius robot rectangle circle |
	super initializeWidgets.
	colors := { Color red. Color green. Color cyan. Color magenta. Color orange }.
	widgetDiameter := 40.
	widgetRadius := widgetDiameter / 2.
	(-120 to: 120 by: 60) withIndexDo: [ : y : index | 
		robot := self addRobotAt: -100@y radius: widgetRadius fillColor: Color yellow borderWidth: 2 borderColor: Color red.	
"		robot angle: (index - 1) * 45."
		rectangle := self addSquareCenter: 0@y length: widgetDiameter fillColor: Color black borderWidth: 5 borderColor: colors atRandom.
		rectangle rotateByDegrees: (index - 1) * 45.
		circle := self addCircleCenter: 100@y radius: widgetRadius fillColor: colors atRandom borderWidth: 1 borderColor: Color black.
	].
	
]

{ #category : #api }
EzDrawingsExample >> title [
	^'Easy UI Drawing Examples'
]
