"
Example methods are class side.

Try evaluating
EzUIExamples windowExample.
EzUIExamples gridExample.

"
Class {
	#name : #EzUIExamplesOLD,
	#superclass : #Object,
	#category : #'EasyUI-ExamplesOLD'
}

{ #category : #examples }
EzUIExamplesOLD class >> gridExample [
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
EzUIExamplesOLD class >> keyboardEventsExample [
	<example>
	| window robot deltaX deltaY initialPosition |
	window := EzWindow openLabelled: 'Easy UI Robot'.
	window contentExtent: 600@400.
	robot := EzRobotWidget new.
	robot bodyColor: Color pink.
	robot pointerColor: Color cyan.
	initialPosition := 300@200.
	window addWidget: robot at: initialPosition.
	robot onKeyDown: Character arrowLeft do: [ 
		robot angle: robot angle + 15 ]. 
	robot onKeyDown: Character arrowRight do: [
		 robot angle: robot angle - 15 ]. 
	robot onKeyDown: Character arrowUp do: [ 
		deltaX := 10 * robot angle degreeCos.
		deltaY := -10 * robot angle degreeSin.
		robot position: robot position + (deltaX@deltaY) ]. 
	robot onKeyUp: Character space do: [ 
		robot angle: 0.
		robot position: initialPosition]

]
