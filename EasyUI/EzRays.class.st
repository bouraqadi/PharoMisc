Class {
	#name : #EzRays,
	#superclass : #EzPolyLine,
	#category : #'EasyUI-Kernel'
}

{ #category : #rendering }
EzRays >> newShapeForCanvas: canvas [
	^canvas createPath: [ : path | 
		path absolute.
		extents do: [ : each |
			path moveTo: 0@0.
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
