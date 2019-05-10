"
I represent a change in one or more instance variables.

    Instance Variables
	ivsDict:		<Symbol -> Object> : map IV names to IV values


    Implementation Points
"
Class {
	#name : #LoIvChangeEvent,
	#superclass : #LoEvent,
	#instVars : [
		'ivsDict'
	],
	#category : #'LightweightObserver-Kernel'
}

{ #category : #accessing }
LoIvChangeEvent >> addIv: ivName newValue: newValue [
	^ivsDict at: ivName put: newValue
]

{ #category : #accessing }
LoIvChangeEvent >> ifChanged: ivName do: aBlock [
	| newValue |
	newValue := ivsDict at: ivName ifAbsent: [ ^self ].
	aBlock cull: newValue
]

{ #category : #initialization }
LoIvChangeEvent >> initialize [
	super initialize.
	ivsDict := Dictionary new 
]

{ #category : #accessing }
LoIvChangeEvent >> newValueFor: ivName [
	^ivsDict at: ivName ifAbsent: [ nil ].
]
