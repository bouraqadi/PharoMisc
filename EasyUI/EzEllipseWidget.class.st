Class {
	#name : #EzEllipseWidget,
	#superclass : #EzWidget,
	#category : #'EasyUI-KernelOLD'
}

{ #category : #initialization }
EzEllipseWidget >> defaultColor [
	^Color yellow
]

{ #category : #initialization }
EzEllipseWidget >> morphClass [
	^EllipseMorph
]
