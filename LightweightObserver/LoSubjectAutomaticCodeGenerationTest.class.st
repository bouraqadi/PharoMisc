Class {
	#name : #LoSubjectAutomaticCodeGenerationTest,
	#superclass : #TestCase,
	#instVars : [
		'factory',
		'class'
	],
	#category : #'LightweightObserver-Test'
}

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> setUp [
	super setUp.
	factory := ClassFactoryForTestCase new.
	class := factory silentlyNewSubclassOf: LoSubject instanceVariableNames: 'a b' classVariableNames: ''.

]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> tearDown [
	super tearDown.
	factory cleanUp.
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testAstReflectsActualBytecode [
	| wrapperAst basicMessageNode |
	class compile:  'a: anObject
		a := anObject'.
	wrapperAst := (class compiledMethodAt: #a:) ast.
	basicMessageNode := wrapperAst allChildren detect: [ : each | each isMessage ] ifNone: [ self fail ].
	self assert: (basicMessageNode selector beginsWith: LoSubject basicMethodSelectorPrefix) 
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testCompilingBasicMethods [
	| originalSource basicSource |
	originalSource :=  'a: anObject
		a := anObject'.
	class compile: originalSource.
	self 
		should: [class compile: 'basicSubjectMethod_a: x'] 
		raise: LoSubjectBasicMethodChangeForbiddenError.
	basicSource := (class compiledMethodAt: #basicSubjectMethod_a:) sourceCode.
	self deny: (basicSource includesSubstring: #basicSubjectMethod_a:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testFileOutIngnoresGeneratedMethods [
	| fileOutStream |
	class compile: 'a: anObject
		a := anObject'.
	fileOutStream := String new writeStream.
	class fileOutOn: fileOutStream.
	self deny: (fileOutStream contents includesSubstring: #basicSubjectMethod_a:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testGeneratingSupportMethodsForMultipleIvAccess [
	class compile: 'a: objA b: objB
	a := objA.
	b := objB.'.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a:b: basicSubjectMethod_a:b:).

]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testGeneratingSupportMethodsUponCompilation [
	class compile: 'a
		^a'.
	self assertCollection: class localSelectors hasSameElements: #(a).
	class compile: 'a: anObject
		a := anObject'.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a a: basicSubjectMethod_a:).
	class compile: 'b
		^b'.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a a: basicSubjectMethod_a: b).
	class compile: 'b: anObject
		b := anObject'.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a a: basicSubjectMethod_a: b b: basicSubjectMethod_b:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testGeneratingSupportMethodsUponInheritance [
	| newClass |
	newClass := factory newSubclassOf: Object instanceVariableNames: 'x'  classVariableNames: ''.
	newClass compile: 'x: anObject
		x := anObject'.
	self assertCollection: newClass localSelectors hasSameElements: #(x:).
	LoSubject subclass: newClass name instanceVariableNames: 'x' classVariableNames: '' package: newClass category.
	self assert: newClass superclass == LoSubject.
	self assertCollection: newClass basicLocalSelectors hasSameElements: #(x: basicSubjectMethod_x:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testGeneratingSupportMethodsWithoutParameters [
	class compile: 'noParam
	a := #().
	b := #objB.'.
	self assertCollection: class basicLocalSelectors hasSameElements: #(noParam #basicSubjectMethod_noParam).

]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testRemovingBasicMethods [
	class compile: 'a: anObject
		a := anObject'.
	self 
		should: [class removeSelector: #basicSubjectMethod_a:] 
		raise: LoSubjectBasicMethodChangeForbiddenError.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a: basicSubjectMethod_a:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testRemovingGeneratedSupportMethodsUponInheritance [
	| newClass |
	newClass := factory newSubclassOf: LoSubject instanceVariableNames: 'x'  classVariableNames: ''.
	newClass compile: 'x: anObject
		x := anObject'.
	self assertCollection: newClass basicLocalSelectors hasSameElements: #(x: basicSubjectMethod_x:).
	Object subclass: newClass name instanceVariableNames: 'x' classVariableNames: '' package: newClass category.
	self assert: newClass superclass == Object.
	self assertCollection: newClass localSelectors hasSameElements: #(x:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testRemovingNonSupportMethods [
	class compile: 'a: anObject
		a := anObject'.
	class compile: 'm'.
	self shouldnt: [class removeSelector: #m] raise: Error.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a: basicSubjectMethod_a:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testRemovingSupportMethods [
	class compile: 'a: anObject
		a := anObject'.
	class compile: 'b: anObject
		b := anObject'.
	class removeSelector: #a:.
	self assertCollection: class basicLocalSelectors hasSameElements: #(b: basicSubjectMethod_b:).
	
	
	
	
]

{ #category : #testing }
LoSubjectAutomaticCodeGenerationTest >> testUpdatingSupportMethods [
	class compile: 'a: anObject
		a := anObject'.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a: basicSubjectMethod_a:).
	class compile: 'a: anObject'.
	self assertCollection: class basicLocalSelectors hasSameElements: #(a:).
	
	
	
	
]
