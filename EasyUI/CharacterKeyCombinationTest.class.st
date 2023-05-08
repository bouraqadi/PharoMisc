Class {
	#name : #CharacterKeyCombinationTest,
	#superclass : #TestCase,
	#category : #'EasyUI-Tests'
}

{ #category : #tests }
CharacterKeyCombinationTest >> testArrowShift [
	| combination modifiedCombination |
	combination := Character arrowDown asKeyCombination.
	modifiedCombination := combination modifiedBy: KMMetaModifier shift.
	self assert: combination key equals: KeyboardKey down.
	self assert: combination modifier equals: KMNoModifier new.
	self assert: modifiedCombination modifier equals: KMModifier shift
]

{ #category : #tests }
CharacterKeyCombinationTest >> testLowercaseKeyCombination [
	| combination |
	combination := $a asKeyCombination.
	self assert: combination key equals: KeyboardKey A.
	self assert: combination modifier equals: KMNoModifier new.
]

{ #category : #tests }
CharacterKeyCombinationTest >> testUppercaseKeyCombination [
	| combination |
	combination := $A asKeyCombination.
	self assert: combination key equals: KeyboardKey A.
	self assert: combination modifier equals: KMModifier shift.
]
