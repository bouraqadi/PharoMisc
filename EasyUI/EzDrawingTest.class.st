Class {
	#name : #EzDrawingTest,
	#superclass : #TestCase,
	#instVars : [
		'drawing'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #running }
EzDrawingTest >> assertRotationAbout: currentCenter [
	| initialPosition previousPosition |
	drawing center: currentCenter.
	initialPosition := drawing currentPosition.
	#(0 360 720) do: [ : newAngle|
		drawing angle: 360.
		self assert: drawing currentPosition equals: initialPosition.
		self assert: drawing currentForm == drawing initialForm.
		self assert: drawing center equals: currentCenter.
	].
	previousPosition := initialPosition.
	30 to: 330 by: 30 do: [ : newAngle |
		drawing angle: newAngle.
		self assert: drawing center equals: currentCenter.
		self deny: drawing currentPosition equals: previousPosition.
	]

]

{ #category : #running }
EzDrawingTest >> testRotationCenterRandom [
	drawing := EzDrawing new.
	self assertRotationAbout: 123@546.

]

{ #category : #running }
EzDrawingTest >> testRotationCenterX0Y0 [
	drawing := EzDrawing new.
	self assertRotationAbout:  0@0.

]

{ #category : #running }
EzDrawingTest >> testTranslation [
	drawing := EzDrawing extent: 5@3.
	self assert: drawing initialForm extent equals: 5@3.
	self assert: drawing center equals: 0@0.
	self assert: drawing currentPosition equals: -2@ -1.
	drawing center: 2@1.
	self assert: drawing currentPosition equals: 0@0.
	drawing center: 4@2.
	self assert: drawing currentPosition equals: 2@1.
	drawing center: -2@ -1.
	self assert: drawing currentPosition equals: -4 @ -2.
	
	
]
