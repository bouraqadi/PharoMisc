Class {
	#name : #SmAutomatonTest,
	#superclass : #TestCase,
	#instVars : [
		'initialState',
		'automaton'
	],
	#category : #'StateMachine-Tests'
}

{ #category : #testing }
SmAutomatonTest >> setUp [
	super setUp.
	automaton := SmAutomaton new.
	initialState := automaton newState.
	automaton initialState: initialState 
]

{ #category : #testing }
SmAutomatonTest >> testAutomaticTransition [
	|newState|
	newState := automaton newState.
	initialState transitionTo: newState.
	automaton step.
	self assert: automaton currentState equals: newState
]

{ #category : #testing }
SmAutomatonTest >> testAutomatonAtInitialState [
	self assert: automaton currentState equals: initialState.
	self assert: initialState automaton equals: automaton
]

{ #category : #testing }
SmAutomatonTest >> testChangeStateWhenTransitionConditionIsVerified [
	|newState flag|
	newState := automaton newState.
	flag := false.
	initialState transitionTo: newState when: [flag].
	flag := true.
	automaton step.
	self assert: automaton currentState equals: newState
]

{ #category : #testing }
SmAutomatonTest >> testCustomState [
	|firstState secondState|
	firstState := automaton newState: SmCustomStateForTest.
	self assert: firstState class == SmCustomStateForTest.
	secondState := automaton newState: SmCustomStateForTest.
	self assert: secondState class == SmCustomStateForTest.
	initialState transitionTo: firstState.
	firstState transitionTo: secondState.
	secondState transitionTo: firstState.
	automaton step.
	self assert: automaton currentState equals: firstState.
	automaton step.
	self assert: automaton currentState equals: secondState.
	automaton step.
	self assert: automaton currentState equals: firstState.
	
]

{ #category : #testing }
SmAutomatonTest >> testEntryActionOfInitialStatePerformed [
	|newState entryActionPeformed|
	entryActionPeformed := false.
	newState := automaton newStateOnEntryDo: [ entryActionPeformed := true ].
	automaton initialState: newState.
	self assert: entryActionPeformed
]

{ #category : #testing }
SmAutomatonTest >> testMainActionOfInitialStatePerformedOnceEnabled [
	| count countingState |
	count := 0.
	countingState := automaton newStateDoing: [ count := count + 1 ].
	automaton initialState: countingState.
	self assert: count equals: 1.

]

{ #category : #testing }
SmAutomatonTest >> testManualTransition [
	| newState exitActionPeformed entryActionPerformed mainActionPerformed |
	exitActionPeformed := false.
	initialState addExitAction: [ exitActionPeformed := true ].
	mainActionPerformed := false.
	entryActionPerformed := false.
	newState := automaton 
		newStateDoing: [ mainActionPerformed := true ] 
		onEntryDo: [entryActionPerformed := true].
	automaton forceTransitionTo: newState.
	self assert: automaton currentState equals: newState.
	self assert: exitActionPeformed.
	self assert: entryActionPerformed.
	self assert: mainActionPerformed.

]

{ #category : #testing }
SmAutomatonTest >> testManualTransitionToTheSameStateDoesNothing [
	| exitActionPeformed entryActionPerformed mainActionPerformed |
	entryActionPerformed := false.
	mainActionPerformed := false.
	exitActionPeformed := false.
	initialState 
		addEntryAction: [entryActionPerformed := true];
		mainActionBlock: [ mainActionPerformed := true ];
		addExitAction: [ exitActionPeformed := true ].
	automaton forceTransitionTo: initialState.
	self assert: automaton currentState equals: initialState.
	self deny: entryActionPerformed.
	self deny: mainActionPerformed.
	self deny: exitActionPeformed.

]

{ #category : #testing }
SmAutomatonTest >> testNilActionsIgnored [
	| newState |
	newState := automaton newStateOnEntryDo: nil onExitDo: nil.
	self assert: newState entryActions isEmpty.
	self assert: newState exitActions isEmpty.

]

{ #category : #testing }
SmAutomatonTest >> testStateEntryActionPerformed [
	|newState entryActionPeformed|
	entryActionPeformed := false.
	newState := automaton newStateOnEntryDo: [ entryActionPeformed := true ].
	initialState transitionTo: newState when: [true].
	automaton step.
	self assert: entryActionPeformed
]

{ #category : #testing }
SmAutomatonTest >> testStateExitActionPerformed [
	|newState exitActionPeformed|
	exitActionPeformed := false.
	newState := automaton newState.
	initialState addExitAction: [ exitActionPeformed := true ].
	initialState transitionTo: newState when: [true].
	automaton step.
	self assert: exitActionPeformed
]

{ #category : #testing }
SmAutomatonTest >> testStateMainActionRepeatedAsLongNoTransitionOccurs [
	| count countingState shouldCount |
	count := 0.
	countingState := automaton newStateDoing: [ count := count + 1 ].
	shouldCount := false.
	initialState transitionTo: countingState when: [shouldCount].
	countingState transitionTo: initialState when: [shouldCount not].
	shouldCount := true.
	1 to: 4 do: [: expectedCount |
		automaton step.
		self assert: count equals: expectedCount].
	shouldCount := false.
	4 timesRepeat: [
		automaton step.
		self assert: count equals: 4]

]

{ #category : #testing }
SmAutomatonTest >> testStateReferencesAutomaton [
	| targetState sourceState |
	self assert: initialState automaton equals: automaton.	
	targetState := automaton newState.
	initialState transitionTo: targetState when: [true].
	self assert: initialState automaton equals: automaton.	
	self assert: targetState automaton equals: automaton.	
	sourceState := automaton newState.
	sourceState transitionTo: initialState when: [true].
	self assert: initialState automaton equals: automaton.	
	self assert: targetState automaton equals: automaton.	
	self assert: sourceState automaton equals: automaton.	
	
]

{ #category : #testing }
SmAutomatonTest >> testStateUnchangedWhenNOTransitionIsActionable [
	|newState flag|
	newState := automaton newState.
	flag := false.
	initialState transitionTo: newState when: [flag].
	automaton step.
	self assert: automaton currentState equals: initialState
]
