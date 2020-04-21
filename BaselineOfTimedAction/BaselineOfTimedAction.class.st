Class {
	#name : #BaselineOfTimedAction,
	#superclass : #BaselineOf,
	#category : #BaselineOfTimedAction
}

{ #category : #baselines }
BaselineOfTimedAction >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: 'TimedAction'.
	]
]
