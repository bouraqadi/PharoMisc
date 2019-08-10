Extension { #name : #Point }

{ #category : #'*SimpleMiddleware' }
Point >> doMarshallingWith: marshaller [
	^marshaller marshallBasicObject: self
]
