"
Placeholder for packages for subject support methods.

See LoSubjectSupportMethod>>#packageFromOrganizer:
"
Class {
	#name : #LoNullPackage,
	#superclass : #Object,
	#category : #'LightweightObserver-Kernel'
}

{ #category : #adding }
LoNullPackage >> addMethod: aCollection [ 
	^self
]

{ #category : #converting }
LoNullPackage >> asRingDefinition [
	^nil
]

{ #category : #testing }
LoNullPackage >> isDefault [
	^true
]

{ #category : #accessing }
LoNullPackage >> name [
	^'NullPackage'
]

{ #category : #accessing }
LoNullPackage >> package [
	^self
]

{ #category : #accessing }
LoNullPackage >> packageManifestOrNil [
	^nil
]

{ #category : #'organization updating' }
LoNullPackage >> updateSelector: oldSelector inClass: aClass withNewSelector: newSelector [
	^self
]
