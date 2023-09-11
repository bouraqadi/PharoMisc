Extension { #name : #UndefinedObject }

{ #category : #'*SimpleMiddleware' }
UndefinedObject >> doMarshallingWith: marshaller [
	^marshaller marshallBasicObject: self
]
