Trait {
	#name : #EzTCenteredDrawing,
	#category : #'EasyUI-Kernel'
}

{ #category : #accessing }
EzTCenteredDrawing >> bounds [
	self explicitRequirement
]

{ #category : #accessing }
EzTCenteredDrawing >> center [
	^self bounds center + self origin
]

{ #category : #accessing }
EzTCenteredDrawing >> center: newCenter [
	self origin: newCenter - self center + self origin
]
