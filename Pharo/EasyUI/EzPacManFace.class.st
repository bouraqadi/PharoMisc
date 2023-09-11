Class {
	#name : #EzPacManFace,
	#superclass : #EzCompositeDrawing,
	#instVars : [
		'body',
		'eye'
	],
	#category : #'EasyUI-Examples-Drawings'
}

{ #category : #accessing }
EzPacManFace >> bodyColor [
	^body fillColor
]

{ #category : #accessing }
EzPacManFace >> bodyColor: aColor [
	body fillColor: aColor
]

{ #category : #accessing }
EzPacManFace >> borderColor [
	^body borderColor
]

{ #category : #accessing }
EzPacManFace >> borderColor: aColor [
	body borderColor: aColor
]

{ #category : #initialization }
EzPacManFace >> defaultBodyAngle [
	self subclassResponsibility
]

{ #category : #initialization }
EzPacManFace >> defaultEyeCenter [
	self subclassResponsibility
]

{ #category : #accessing }
EzPacManFace >> eyeColor [
	^eye fillColor
]

{ #category : #accessing }
EzPacManFace >> eyeColor: aColor [
	eye fillColor: aColor
]

{ #category : #initialization }
EzPacManFace >> initialize [
	super initialize.
	body := EzArc radius: 100 angleSpan: 300.
	body angle: self defaultBodyAngle.
	self bodyColor: Color yellow.
	eye := EzOval circleCenter: self defaultEyeCenter diameter: 25.
	eye borderWidth: 0.
	self eyeColor: Color black.
	self
		addAll:
			{body.
			eye}
]
