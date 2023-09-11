Extension { #name : #Number }

{ #category : #'*SimpleMiddleware' }
Number >> doMarshallingWith: marshaller [
	^marshaller marshallBasicObject: self
]
