Extension { #name : #Color }

{ #category : #'*SimpleMiddleware' }
Color >> doMarshallingWith: marshaller [
	^marshaller marshallBasicObject: self
]
