Class {
	#name : #EzClosedDrawing,
	#superclass : #EzDrawing,
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
EzClosedDrawing >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
EzClosedDrawing >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
EzClosedDrawing >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #accessing }
EzClosedDrawing >> fillColor [
	^ fillColor
]

{ #category : #accessing }
EzClosedDrawing >> fillColor: anObject [
	fillColor := anObject
]
