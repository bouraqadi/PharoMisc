Class {
	#name : #EzNaturalReferentialDrawings,
	#superclass : #EzDrawing,
	#category : #'EasyUI-Kernel'
}

{ #category : #converting }
EzNaturalReferentialDrawings >> convertFromNaturalToRoassal: pointInNaturalReferential [
	^(pointInNaturalReferential x + self minX) @ (pointInNaturalReferential y negated - self minY)
]

{ #category : #converting }
EzNaturalReferentialDrawings >> convertFromRoassalToNatural: pointInRoassalReferential [
	^(pointInRoassalReferential x - self minX) @ (pointInRoassalReferential y + self minY) negated
]

{ #category : #testing }
EzNaturalReferentialDrawings >> isVisiblePoint: aPoint [
	^super isVisiblePoint: (self convertFromNaturalToRoassal: aPoint)
]
