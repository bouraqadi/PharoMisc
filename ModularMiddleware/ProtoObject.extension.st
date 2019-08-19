Extension { #name : #ProtoObject }

{ #category : #'*ModularMiddleware' }
ProtoObject >> marshalWith: aMarshaller [
	^aMarshaller proxyFor: self
]

{ #category : #'*ModularMiddleware' }
ProtoObject >> unmarshalWith: aMarshaller [
	^aMarshaller unmarshalObject: self
]
