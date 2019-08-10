Extension { #name : #Object }

{ #category : #'*SimpleMiddleware' }
Object >> doMarshallingWith: marshaller [
	^marshaller marshallPlainObject: self.
]

{ #category : #'*SimpleMiddleware' }
Object >> doUnmarshallingWith: marshaller [
	^marshaller unmarshallBasicObject: self.
]
