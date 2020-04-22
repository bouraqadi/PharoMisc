Class {
	#name : #BaselineOfTasks,
	#superclass : #Object,
	#category : #BaselineOfTasks
}

{ #category : #baselines }
BaselineOfTasks >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: 'Tasks'.
	]
]
