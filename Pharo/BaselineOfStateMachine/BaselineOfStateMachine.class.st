Class {
	#name : 'BaselineOfStateMachine',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfStateMachine',
	#package : 'BaselineOfStateMachine'
}

{ #category : 'baselines' }
BaselineOfStateMachine >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #StateMachine. ].

]
