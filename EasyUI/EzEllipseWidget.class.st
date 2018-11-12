Class {
	#name : #EzEllipseWidget,
	#superclass : #EzWidget,
	#category : #'EasyUI-Kernel'
}

{ #category : #initialization }
EzEllipseWidget >> defaultColor [
	^Color yellow
]

{ #category : #initialization }
EzEllipseWidget >> morphClass [
	^EllipseMorph
]
