Class {
	#name : #EzTurtleBot,
	#superclass : #EzCompositeDrawing,
	#instVars : [
		'laser',
		'body',
		'heading'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #rendering }
EzTurtleBot >> borderColor [
	^body borderColor
]

{ #category : #rendering }
EzTurtleBot >> borderColor: aColor [
	body borderColor: aColor.
	heading color: aColor.
]

{ #category : #rendering }
EzTurtleBot >> fillColor [
	^body fillColor 
]

{ #category : #rendering }
EzTurtleBot >> fillColor: aColor [
	body fillColor: aColor
]

{ #category : #rendering }
EzTurtleBot >> hideLaser [
	laser hide
]

{ #category : #initialization }
EzTurtleBot >> initialize [
	| bodyRadius |
	super initialize.
	bodyRadius := 50.
	body := EzOval circleCenter: 0@0 radius: bodyRadius.
	body borderWidth: 2.
	heading := EzPolyLine from: 0 @ 0 to: bodyRadius @ 0.
	heading width: 5.
	laser := EzRays spanAngle: 270 radius: 200 angleStep: 3.
	laser angle: -135.
	laser color: Color red.
	laser width: 1.
	self borderColor: Color black.
	self fillColor: Color yellow.
	self addAll: { body. heading. laser }
]

{ #category : #rendering }
EzTurtleBot >> isShowingLaser [
	^laser isShowing 
]

{ #category : #rendering }
EzTurtleBot >> showLaser [
	laser show
]