"
Placeholder for packages for subject support methods.

See LoSubjectSupportMethod>>#packageFromOrganizer:
"
Class {
	#name : #LoNullPackage,
	#superclass : #Object,
	#category : #'LightweightObserver-Kernel'
}

{ #category : #'as yet unclassified' }
LoNullPackage >> addMethod: aCollection [ 
	^self
]

{ #category : #converting }
LoNullPackage >> asRingDefinition [
	^self
]

{ #category : #testing }
LoNullPackage >> isDefault [
	^true
]

{ #category : #accessing }
LoNullPackage >> name [
	^'NullPackage'
]

{ #category : #'organization updating' }
LoNullPackage >> updateSelector: oldSelector inClass: aClass withNewSelector: newSelector [
	^self
]
