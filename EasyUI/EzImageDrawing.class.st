Class {
	#name : #EzImageDrawing,
	#superclass : #EzDrawing,
	#instVars : [
		'image'
	],
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzImageDrawing class >> image: aForm [
	^self new
		image: aForm;
		yourself	
]

{ #category : #'instance creation' }
EzImageDrawing class >> imageFilePath: pathString [
	| image |
	image := self imageFromFilePath: pathString.
	^ self image: image
]

{ #category : #'instance creation' }
EzImageDrawing class >> imageFromFilePath: pathString [
	^ ImageReadWriter formFromFileNamed: pathString
]

{ #category : #accessing }
EzImageDrawing >> bounds [
	^ 0@0 extent: image extent
]

{ #category : #rendering }
EzImageDrawing >> drawOn: aCanvas [
	| cached |
	cached := aCanvas
		cacheAt: image
		ifAbsentPut: [ image asAthensPaintOn: aCanvas ].
	aCanvas setPaint: cached.
	aCanvas paintTransform
		restoreAfter: [ 
			aCanvas drawShape: self bounds ]
]

{ #category : #accessing }
EzImageDrawing >> image [
	^ image
]

{ #category : #accessing }
EzImageDrawing >> image: anObject [
	image := anObject
]
