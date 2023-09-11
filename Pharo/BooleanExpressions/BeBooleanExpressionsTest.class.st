"
This package introduces extensions to collections to make it easy to write usual expressions.
The goal is to avoid writing long sequences of logic messages such as:

exp1 or: [ exp2 or: [exp3 or: [exp4]]

exp1 and: [ exp2 and: [exp3 and: [exp4]]

Usage:
{[exp1]. [exp2]. [exp3]. [exp4]} anyTrue; allTrue; anyFalse; allFalse

Note that boolean expressions are inside blocks to allow for delayed evaluation.
But, this is of course not mandatory.
"
Class {
	#name : #BeBooleanExpressionsTest,
	#superclass : #TestCase,
	#category : #'BooleanExpressions-Test'
}

{ #category : #testing }
BeBooleanExpressionsTest >> testAllFalse [
	| allFalse |
	allFalse := {false. false. false}.
	self deny: allFalse anyTrue. "false"
	self assert: allFalse anyFalse. "true"
	self deny: allFalse allTrue. "false"
	self assert: allFalse allFalse. "true"
]

{ #category : #testing }
BeBooleanExpressionsTest >> testAllFalseBlock [
	| allFalse |
	allFalse := {[10 = 20]. [80 = 50]. [109 = 0]}.
	self deny: allFalse anyTrue. "false"
	self assert: allFalse anyFalse. "true"
	self deny: allFalse allTrue. "false"
	self assert: allFalse allFalse. "true"
]

{ #category : #testing }
BeBooleanExpressionsTest >> testAllTrue [
	| allTrue |
	allTrue := {true. true. true}.
	self assert: allTrue anyTrue. "true"
	self deny: allTrue anyFalse. "false"
	self assert: allTrue allTrue. "true"
	self deny: allTrue allFalse. "false"

]

{ #category : #testing }
BeBooleanExpressionsTest >> testAllTrueBlock [
	| allTrue |
	allTrue := {[1 + 1 = 2]. [2 + 3 = 5]. [0 * 9 = 0]}.
	self assert: allTrue anyTrue. "true"
	self deny: allTrue anyFalse. "false"
	self assert: allTrue allTrue. "true"
	self deny: allTrue allFalse. "false"

]

{ #category : #testing }
BeBooleanExpressionsTest >> testEmptyCollection [
	self deny: #() anyTrue. 
	self deny: #() anyFalse. 
	self deny: #() allTrue.
	self deny: #() allFalse.

]

{ #category : #testing }
BeBooleanExpressionsTest >> testSomeTrueSomeFalse [
	| someTrueSomeFalse |
	someTrueSomeFalse := {false. true. false. true}.
	self assert: someTrueSomeFalse anyTrue. "true"
	self assert: someTrueSomeFalse anyFalse. "true"
	self deny: someTrueSomeFalse allTrue. "false"
	self deny: someTrueSomeFalse allFalse. "false"

]

{ #category : #testing }
BeBooleanExpressionsTest >> testSomeTrueSomeFalseBlock [
	| someTrueSomeFalse |
	someTrueSomeFalse := {[ 10 < 2]. [ 3 < 5 ]. [ 15 < 33]. [ 42 < 6 ]}.
	self assert: someTrueSomeFalse anyTrue. "true"
	self assert: someTrueSomeFalse anyFalse. "true"
	self deny: someTrueSomeFalse allTrue. "false"
	self deny: someTrueSomeFalse allFalse. "false"

]
