Class {
	#name : #EzRoundBot,
	#superclass : #EzCompositeDrawing,
	#instVars : [
		'laser',
		'body',
		'heading'
	],
	#category : #'EasyUI-Examples-Drawings'
}

{ #category : #accessing }
EzRoundBot >> borderColor [
	^body borderColor
]

{ #category : #accessing }
EzRoundBot >> borderColor: aColor [
	body borderColor: aColor.
	heading color: aColor.
]

{ #category : #accessing }
EzRoundBot >> fillColor [
	^body fillColor 
]

{ #category : #accessing }
EzRoundBot >> fillColor: aColor [
	body fillColor: aColor
]

{ #category : #rendering }
EzRoundBot >> hideLaser [
	laser hide
]

{ #category : #initialization }
EzRoundBot >> initialize [
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
EzRoundBot >> isShowingLaser [
	^laser isShowing 
]

{ #category : #accessing }
EzRoundBot >> laserColor [
	^laser color
]

{ #category : #accessing }
EzRoundBot >> laserColor: aColor [
	laser color: aColor
]

{ #category : #rendering }
EzRoundBot >> showLaser [
	laser show
]
