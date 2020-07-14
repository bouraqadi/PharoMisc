Class {
	#name : #EzRays,
	#superclass : #EzPolyLine,
	#category : #'EasyUI-Kernel'
}

{ #category : #'instance creation' }
EzRays class >> raysCount: raysCount spanAngle: spanAngle radius: radius [
	^self new
		raysCount: raysCount spanAngle: spanAngle radius: radius;
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
		extents do: [ : each |
			path absolute.
			path moveTo: 0@0.
			path relative.
			path lineTo: each.
		].
	].

]

{ #category : #initialization }
EzRays >> raysCount: raysCount spanAngle: spanAngle radius: radius [
	| deltaAngle rayAngle ray |
	extents := OrderedCollection new.
	deltaAngle := spanAngle / raysCount.
	rayAngle := 0.
	raysCount timesRepeat: [
		ray := (radius * rayAngle degreeCos) @ (radius * rayAngle degreeSin).
		extents add: ray.
		rayAngle := rayAngle + deltaAngle.
	].


]
