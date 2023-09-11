Class {
	#name : #EzCompositeDrawing,
	#superclass : #EzDrawing,
	#traits : 'EzTDrawingContainer',
	#classTraits : 'EzTDrawingContainer classTrait',
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzCompositeDrawing class >> withAll: drawings [
	^self new
		addAll: drawings;
		yourself
]

{ #category : #initialization }
EzCompositeDrawing >> initialize [
	super initialize.
	self initDrawings.
]
