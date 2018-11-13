"
Example methods are class side.

Try evaluating
EzUIExamples windowExample.
EzUIExamples gridExample.

"
Class {
	#name : #EzUIExamples,
	#superclass : #Object,
	#category : #'EasyUI-Examples'
}

{ #category : #examples }
EzUIExamples class >> gridExample [
	<example>
	| window rectangle colors rectangleColor cellIndex |
	window := EzGridWindow openLabelled: 'Eazy UI Grid'.
	window backgroundColor: Color lightGray.
	window contentExtent: 500@500.
	window beFixedSize.
	window pixelsPerPoint: 50.
	colors := {Color yellow. Color black}.
	1 to: 10 do: [ : y |
		1 to: 10 do: [ : x |
			rectangle := EzRectangleWidget newExtent: 48 @ 48.
			cellIndex := x+(y - 1).
			rectangleColor := colors at: (cellIndex % 2) + 1.
			rectangle color: rectangleColor.
			window addWidget: rectangle at: x@y.
			 ] ].


]

{ #category : #examples }
EzUIExamples class >> windowExample [
	<example>
	| window robot rectangle circle colors |
	window := EzWindow openLabelled: 'Easy UI Window with Widgets'.
	window backgroundColor: Color paleBlue.
	window contentExtent: 600@400.
	colors := { Color red. Color green. Color cyan. Color magenta. Color orange }.
	(60 to: 320 by: 60) withIndexDo: [ : y : index | 
		robot := EzRobotWidget new.	
		robot angle: (index - 1) * 45.
		window addWidget: robot at: 100@y.
		rectangle := EzRectangleWidget new.
		rectangle angle: (index - 1) * 45.
		window addWidget: rectangle at: 200@y.
		circle := EzEllipseWidget new.
		circle color: colors atRandom.
		window addWidget: circle at: 300@y.
	].


]
