"
I am in charge of exporting local objects and delivering to them messages received from romote middlewares. Exporting objects can be done explicitly by a developer. It can be done implicitly (the most frequent case) when passaing objects as parameters of remote messages.

    Instance Variables
	idCounter:		<Integer> counter of automatically exported objects
	targetObjectsDict:		<Dictionary> maps identifiers to local objects

"
Class {
	#name : #SmDispatcher,
	#superclass : #Object,
	#instVars : [
		'targetObjectsDict',
		'idCounter'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #dispatching }
SmDispatcher >> dispatch: aRemoteMessage [
	| receiver |
	receiver := self objectAt: aRemoteMessage receiverId.
	^receiver perform: aRemoteMessage selector withArguments: aRemoteMessage arguments.
]

{ #category : #exporting }
SmDispatcher >> export: anObject [
	| id |
	(self isExported: anObject) ifTrue: [ ^self idAt: anObject ].
	id := self newId.
	self export: anObject as: id.
	^id.
]

{ #category : #exporting }
SmDispatcher >> export: anObject as: id [
	targetObjectsDict at: id put: anObject.
]

{ #category : #accessing }
SmDispatcher >> idAt: anObject [
	^targetObjectsDict keyAtValue: anObject.
]

{ #category : #initialization }
SmDispatcher >> initialize [
	super initialize.
	targetObjectsDict := Dictionary new.
	idCounter := 0.
]

{ #category : #exporting }
SmDispatcher >> isExported: anObject [
	^targetObjectsDict values includes: anObject
]

{ #category : #exporting }
SmDispatcher >> newId [
	idCounter := idCounter + 1.
	^idCounter
]

{ #category : #accessing }
SmDispatcher >> objectAt: id [ 
	^targetObjectsDict at: id
]
