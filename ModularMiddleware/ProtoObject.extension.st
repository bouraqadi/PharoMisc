Extension { #name : #ProtoObject }

{ #category : #'*ModularMiddleware' }
ProtoObject >> marshalWith: aMarshaller [
	^aMarshaller marshalObject: self
]

{ #category : #'*ModularMiddleware' }
ProtoObject >> unmarshalWith: aMarshaller [
	^aMarshaller unmarshalObject: self
]
