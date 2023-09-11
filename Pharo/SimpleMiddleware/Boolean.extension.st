Extension { #name : #Boolean }

{ #category : #'*SimpleMiddleware' }
Boolean >> doMarshallingWith: marshaller [
	^marshaller marshallBasicObject: self
]
