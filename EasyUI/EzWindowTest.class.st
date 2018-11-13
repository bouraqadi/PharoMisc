Class {
	#name : #EzWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'window'
	],
	#category : #'EasyUI-Tests'
}

{ #category : #running }
EzWindowTest >> setUp [
	super setUp.
	window := self windowClass openLabelled: self className.
	
]

{ #category : #running }
EzWindowTest >> tearDown [
	super tearDown.
	window close
	
]

{ #category : #tests }
EzWindowTest >> testColor [
	{Color red. Color green. Color blue. Color orange. Color black } do: [ : aColor |
		window backgroundColor: aColor.
		self assert: window backgroundColor equals: aColor.
		self assert: window rootMorph color equals: aColor.
	]
	 
]

{ #category : #running }
EzWindowTest >> windowClass [
	^EzWindow
]
