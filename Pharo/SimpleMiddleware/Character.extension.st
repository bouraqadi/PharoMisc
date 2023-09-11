Extension { #name : #Character }

{ #category : #'*SimpleMiddleware' }
Character >> doMarshallingWith: marshaller [
	^marshaller marshallBasicObject: self
]
