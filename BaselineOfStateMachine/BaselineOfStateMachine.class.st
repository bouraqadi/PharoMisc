Class {
	#name : #BaselineOfStateMachine,
	#superclass : #BaselineOf,
	#category : #BaselineOfStateMachine
}

{ #category : #baselines }
BaselineOfStateMachine >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #StateMachine. ].

]
