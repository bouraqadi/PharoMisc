Class {
	#name : #SmDispatcherTest,
	#superclass : #TestCase,
	#instVars : [
		'dispatcher'
	],
	#category : #'SimpleMiddleware-Test'
}

{ #category : #testing }
SmDispatcherTest >> setUp [
	super setUp.
	dispatcher := SmMiddleware new dispatcher.
]

{ #category : #testing }
SmDispatcherTest >> testDispatching [
	| object id result message |
	object := #($a $b $c).
	id := dispatcher export: object.
	message := SmRemoteMessage receiverId: id selector: #at: arguments: #(2).
	result := dispatcher dispatch: message.
	self assert: result equals: $b.
	
]

{ #category : #testing }
SmDispatcherTest >> testExportingWithId [
	| object id result |
	object := #($a $b $c).
	id := #myObject.
	dispatcher export: object as: id.
	result := dispatcher objectAt: id.
	self assert: result == object.
	
]

{ #category : #testing }
SmDispatcherTest >> testExportingWithoutId [
	| object id result |
	object := #($a $b $c).
	id := dispatcher export: object.
	result := dispatcher objectAt: id.
	self assert: result == object.
	
]

{ #category : #testing }
SmDispatcherTest >> testExportingWithoutIdSeveralTimes [
	| object id result newId |
	object := #($a $b $c).
	id := dispatcher export: object.
	2 timesRepeat: [ 
		newId := dispatcher export: object.
		self assert: newId == id.
		result := dispatcher objectAt: newId.
		self assert: result == object.
	]
	
]
