Class {
	#name : #EzAppTest,
	#superclass : #TestCase,
	#instVars : [
		'app'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #running }
EzAppTest >> setUp [
	super setUp.
	app := EzApp new.
	app openWindow
]

{ #category : #running }
EzAppTest >> tearDown [
	super tearDown.
	app closeWindow
]

{ #category : #running }
EzAppTest >> testCloseWindowBeforeOpening [
	| otherApp |
	otherApp := EzApp new.
	self shouldnt: [otherApp closeWindow] raise: Exception.
]

{ #category : #running }
EzAppTest >> testWindowPositionChange [
	| newPosition |
	newPosition := app window position + 200.
	app windowPosition: newPosition.
	self assert: app window position equals: newPosition.
	self assert: app windowPosition equals: newPosition.
]

{ #category : #running }
EzAppTest >> testWindowResizingForbidden [
	self deny: app window isResizeable.
]

{ #category : #running }
EzAppTest >> testWindowTitle [
	| newTitle |
	newTitle := 'new title for test'.
	app title: newTitle.
	self assert: app window title equals: newTitle
]
