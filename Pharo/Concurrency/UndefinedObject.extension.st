Extension { #name : 'UndefinedObject' }

{ #category : '*Concurrency' }
UndefinedObject >> shouldLogWithEpicea [
	"In some tests message #shouldLogWithEpicea after the test is GCed and we get nil instead"
	^TestCase shouldLogWithEpicea
]
