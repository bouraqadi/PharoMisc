Class {
	#name : #EzClosedDrawing,
	#superclass : #EzDrawingOLD,
	#instVars : [
		'fillColor',
		'borderColor',
		'borderWidth'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzClosedDrawing >> borderColor [
	^ borderColor
]

{ #category : #accessing }
EzClosedDrawing >> borderColor: aColor [
	borderColor := aColor.

]

{ #category : #accessing }
EzClosedDrawing >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
EzClosedDrawing >> borderWidth: anInt [
	borderWidth := anInt.

]

{ #category : #accessing }
EzClosedDrawing >> fillColor [
	^ fillColor
]

{ #category : #accessing }
EzClosedDrawing >> fillColor: anObject [
	fillColor := anObject
]
