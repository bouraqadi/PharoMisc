Class {
	#name : #BaselineOfTasks,
	#superclass : #BaselineOf,
	#category : #BaselineOfTasks
}

{ #category : #baselines }
BaselineOfTasks >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'StateMachine' with: [
				spec
					repository: 'github://bouraqadi/PharoMisc' ].
		spec 
			package: 'Tasks'.
	]
]
