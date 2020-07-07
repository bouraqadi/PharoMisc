Class {
	#name : #EzCompositeDrawing,
	#superclass : #EzDrawing,
	#traits : 'EzTDrawingArea',
	#classTraits : 'EzTDrawingArea classTrait',
	#instVars : [
		'drawings'
	],
	#category : #'EasyUI-Drawings'
}

{ #category : #drawing }
EzCompositeDrawing >> drawOn: aCanvas [
	self drawings do: [ : each | each drawOn: aCanvas ]
]

{ #category : #accessing }
EzCompositeDrawing >> drawings [
	^drawings
]

{ #category : #initialization }
EzCompositeDrawing >> initialize [
	super initialize.
	drawings := OrderedCollection new.

]
