Class {
	#name : #EzPacMan,
	#superclass : #EzCompositeDrawing,
	#instVars : [
		'body',
		'eye'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzPacMan >> bodyColor [
	^body fillColor
]

{ #category : #accessing }
EzPacMan >> bodyColor: aColor [
	body fillColor: aColor
]

{ #category : #accessing }
EzPacMan >> borderColor [
	^body borderColor
]

{ #category : #accessing }
EzPacMan >> borderColor: aColor [
	body borderColor: aColor
]

{ #category : #accessing }
EzPacMan >> eyeColor [
	^eye fillColor
]

{ #category : #accessing }
EzPacMan >> eyeColor: aColor [
	eye fillColor: aColor
]

{ #category : #initialization }
EzPacMan >> initialize [
	super initialize.
	body := EzArc radius: 100 angleSpan: 300.
	body angle: 30.
	self bodyColor: Color yellow.
	eye := EzOval circleCenter: 30 @ -50 diameter: 25.
	eye borderWidth: 0.
	self eyeColor: Color black.
	self
		addAll:
			{body.
			eye}
]
