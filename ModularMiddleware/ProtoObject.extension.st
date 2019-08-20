Extension { #name : #ProtoObject }

{ #category : #'*ModularMiddleware' }
ProtoObject >> isPassByCopy [
	^false
]

{ #category : #'*ModularMiddleware' }
ProtoObject >> isPassByReference [
	^self isPassByCopy not
]

{ #category : #'*ModularMiddleware' }
ProtoObject >> marshalWith: aMarshaller [
	^aMarshaller marshalObject: self
]

{ #category : #'*ModularMiddleware' }
ProtoObject >> unmarshalWith: aMarshaller [
	^aMarshaller unmarshalObject: self
]
