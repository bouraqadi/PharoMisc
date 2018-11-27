Class {
	#name : #EzRobotWidget,
	#superclass : #EzEllipseWidget,
	#instVars : [
		'directionPointer'
	],
	#category : #'EasyUI-WidgetsLibrary'
}

{ #category : #initialization }
EzRobotWidget >> bodyColor: aColor [
	morph color: aColor
]

{ #category : #initialization }
EzRobotWidget >> defaultBodyColor [
	^Color blue
]

{ #category : #initialization }
EzRobotWidget >> defaultColor [
	^self defaultBodyColor
]

{ #category : #initialization }
EzRobotWidget >> defaultDirectionPointerColor [
	^ Color red
]

{ #category : #initialization }
EzRobotWidget >> initialize [
	super initialize.
	directionPointer := Morph new.
	directionPointer extent: 10 @ 10.
	self pointerColor: self defaultDirectionPointerColor.
	morph addMorph: directionPointer.
	directionPointer position: (self defaultExtent x // 2 - 5) @ 0
]

{ #category : #initialization }
EzRobotWidget >> pointerColor: aColor [
	directionPointer color: aColor
]
