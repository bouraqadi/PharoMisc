Extension { #name : #String }

{ #category : #'*ModularMiddleware' }
String class >> marshalWith: marshaller [
	^marshaller marshalString: self 
]

{ #category : #'*ModularMiddleware' }
String class >> unmarshalWith: marshaller [
	^marshaller unmarshalString: self 
]
