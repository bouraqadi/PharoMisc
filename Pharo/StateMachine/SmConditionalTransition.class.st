"
I am a transition which performs when a condition to be satisfied

Instance Variables
	conditionBlock:		<BlockClosure>

conditionBlock
	- A block which value is a boolean. When it's value is true, the transition can be peformed, so the target state can be activated, and the source state can be desactivated.

"
Class {
	#name : #SmConditionalTransition,
	#superclass : #SmTransition,
	#instVars : [
		'conditionBlock'
	],
	#category : #'StateMachine-Kernel'
}

{ #category : #'instance creation' }
SmConditionalTransition class >> from: sourceState to: targetState when: conditionBlock [ 
	^(self from: sourceState to: targetState)
		conditionBlock: conditionBlock;
		yourself
]

{ #category : #accessing }
SmConditionalTransition >> conditionBlock [
	^ conditionBlock
]

{ #category : #accessing }
SmConditionalTransition >> conditionBlock: anObject [
	conditionBlock := anObject
]

{ #category : #stepping }
SmConditionalTransition >> isActionable [
	^conditionBlock value
]
