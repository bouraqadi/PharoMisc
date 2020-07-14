Class {
	#name : #EzClosedDrawingOLD,
	#superclass : #EzDrawingOLD,
	#instVars : [
		'fillColor',
		'borderColor',
		'borderWidth'
	],
	#category : #'EasyUI-DrawingsOLD'
}

{ #category : #accessing }
EzClosedDrawingOLD >> borderColor [
	^ borderColor
]

{ #category : #accessing }
EzClosedDrawingOLD >> borderColor: aColor [
	borderColor := aColor.

]

{ #category : #accessing }
EzClosedDrawingOLD >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
EzClosedDrawingOLD >> borderWidth: anInt [
	borderWidth := anInt.

]

{ #category : #accessing }
EzClosedDrawingOLD >> fillColor [
	^ fillColor
]

{ #category : #accessing }
EzClosedDrawingOLD >> fillColor: anObject [
	fillColor := anObject
]
