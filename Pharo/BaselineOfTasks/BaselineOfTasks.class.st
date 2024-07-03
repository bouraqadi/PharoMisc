Class {
	#name : 'BaselineOfTasks',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfTasks',
	#package : 'BaselineOfTasks'
}

{ #category : 'baselines' }
BaselineOfTasks >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'StateMachine' with: [
				spec
					repository: 'github://bouraqadi/PharoMisc:pharo12' ].
		spec 
			package: 'Tasks'.
	]
]
