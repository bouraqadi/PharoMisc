Class {
	#name : #EzRays,
	#superclass : #EzPolyLine,
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzRays class >> spanAngle: spanAngle radius: radius angleStep: deltaAngle [
	^ self new
		spanAngle: spanAngle radius: radius angleStep: deltaAngle;
		yourself
]

{ #category : #'instance creation' }
EzRays class >> spanAngle: spanAngle radius: radius raysCount: raysCount [
	^ self new
		spanAngle: spanAngle radius: radius raysCount: raysCount;
		yourself
]

{ #category : #accessing }
EzRays >> center [
	^self origin
]

{ #category : #accessing }
EzRays >> center: newCenter [
	^self origin: newCenter
]

{ #category : #rendering }
EzRays >> newShapeForCanvas: canvas [
	^canvas createPath: [ : path | 
		self extents do: [ : each |
			path absolute.
			path moveTo: 0@0.
			path relative.
			path lineTo: each.
		].
	].

]

{ #category : #initialization }
EzRays >> spanAngle: spanAngle radius: radius angleStep: deltaAngle [
	| rayAngle ray newExtents |
	newExtents := OrderedCollection new.
	rayAngle := 0.
	[rayAngle <= spanAngle] whileTrue: [
		ray := (radius * rayAngle degreeCos) @ (radius * rayAngle degreeSin).
		newExtents add: ray.
		rayAngle := rayAngle + deltaAngle.
	].
	self extents: newExtents


]

{ #category : #initialization }
EzRays >> spanAngle: spanAngle radius: radius raysCount: raysCount [
	self 
		spanAngle: spanAngle
		radius: radius
		angleStep: spanAngle / raysCount.
	
]
