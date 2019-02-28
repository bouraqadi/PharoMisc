Class {
	#name : #EzLine,
	#superclass : #EzDrawing,
	#instVars : [
		'startPoint',
		'endPoint',
		'width',
		'color'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzLine >> color [
	^ color
]

{ #category : #accessing }
EzLine >> color: anObject [
	color := anObject
]

{ #category : #drawing }
EzLine >> drawOn: aCanvas [
	aCanvas 
		line: self startPoint 
		to: self endPoint 
		width: self width 
		color: self color
]

{ #category : #accessing }
EzLine >> endPoint [
	^ endPoint
]

{ #category : #accessing }
EzLine >> endPoint: anObject [
	endPoint := anObject
]

{ #category : #accessing }
EzLine >> startPoint [
	^ startPoint
]

{ #category : #accessing }
EzLine >> startPoint: anObject [
	startPoint := anObject
]

{ #category : #accessing }
EzLine >> width [
	^ width
]

{ #category : #accessing }
EzLine >> width: anObject [
	width := anObject
]
