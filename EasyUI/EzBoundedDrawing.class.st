Class {
	#name : #EzBoundedDrawing,
	#superclass : #EzClosedDrawing,
	#instVars : [
		'boundingBox'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzBoundedDrawing >> boundingBox [
	^ boundingBox
]

{ #category : #accessing }
EzBoundedDrawing >> boundingBox: anObject [
	boundingBox := anObject
]
