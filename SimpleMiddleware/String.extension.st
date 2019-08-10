Extension { #name : #String }

{ #category : #'*SimpleMiddleware' }
String >> doMarshallingWith: marshaller [
	^marshaller marshallBasicObject: self
]
