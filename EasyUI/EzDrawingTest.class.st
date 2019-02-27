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
	initialPosition := drawing position.
	#(0 360 720) do: [ : newAngle|
		drawing angle: 360.
		self assert: drawing position equals: initialPosition.
		self assert: drawing currentForm == drawing initialForm.
		self assert: drawing center equals: currentCenter.
	].
	previousPosition := initialPosition.
	30 to: 330 by: 30 do: [ : newAngle |
		drawing angle: newAngle.
		self assert: drawing center equals: currentCenter.
		self deny: drawing position equals: previousPosition.
	]

]

{ #category : #running }
EzDrawingTest >> testCenterChange [
	drawing := EzDrawing extent: 5@3.
	self assert: drawing initialForm extent equals: 5@3.
	self assert: drawing center equals: 0@0.
	self assert: drawing position equals: -2@ -1.
	drawing center: 2@1.
	self assert: drawing position equals: 0@0.
	drawing center: 4@2.
	self assert: drawing position equals: 2@1.
	drawing center: -2@ -1.
	self assert: drawing position equals: -4 @ -2.
	
	
]

{ #category : #running }
EzDrawingTest >> testPositionChange [
	drawing := EzDrawing extent: 5@3.
	self assert: drawing position equals: -2@ -1.
	drawing position: 0@0.
	self assert: drawing center equals: 2@1.
	drawing position: 2@1.
	self assert: drawing center equals: 4@2.
	drawing position: -4 @ -2.
	self assert: drawing center equals: -2@ -1.
	
	
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
