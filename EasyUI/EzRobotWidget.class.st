Class {
	#name : #EzRobotWidget,
	#superclass : #EzEllipseWidget,
	#category : #'EasyUI-WidgetsLibrary'
}

{ #category : #initialization }
EzRobotWidget >> defaultColor [
	^Color blue
]

{ #category : #initialization }
EzRobotWidget >> initialize [
	| directionPointer |
	super initialize.
	directionPointer := Morph new.
	directionPointer extent: 10@10.
	directionPointer color: Color red.
	morph addMorph: directionPointer.
	directionPointer position: (self defaultExtent x // 2 - 5)@0.
]
