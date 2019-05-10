Extension { #name : #Collection }

{ #category : #'*LightweightObserver' }
Collection class >> adoptInstance: aCollection [
	[ super adoptInstance: aCollection ] 
		on: Error 
		do: [ (self withAll: aCollection) become: aCollection ]
]
