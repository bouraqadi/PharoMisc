"
I am a compiled method transformed by a subject to hide boiler plate code by providing a nice ""source"" for the browser, while still providing an accurate AST. 
See :
CompiledMethod>>#ast
LoSubjectSupportMethod>>#parseTree
"
Class {
	#name : #LoSubjectSupportMethod,
	#superclass : #CompiledMethod,
	#type : #compiledMethod,
	#category : #'LightweightObserver-Kernel'
}

{ #category : #parsing }
LoSubjectSupportMethod >> ast [
	"The source code is fake, just to hide boiler plate code and ease development"
	^self parseTree doSemanticAnalysisIn: self methodClass
]

{ #category : #testing }
LoSubjectSupportMethod >> isBasicMethod [
	^LoSubject isBasicMethodSelector: self selector
]

{ #category : #package }
LoSubjectSupportMethod >> packageFromOrganizer: organizer [
	| package |
	"This is a bad fix to the unpackaged code problem. Just avoids the debugger poping out during compilation."
	package := super packageFromOrganizer: organizer.
	package ifNotNil: [ ^package ].
	^LoNullPackage new
]

{ #category : #parsing }
LoSubjectSupportMethod >> parseTree [
	"The source code is fake, just to hide boiler plate code and ease development"
	^ self decompile
]
