Class {
	#name : #BaselineOfBooleanExpressions,
	#superclass : #BaselineOf,
	#category : #BaselineOfBooleanExpressions
}

{ #category : #baselines }
BaselineOfBooleanExpressions >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #BooleanExpressions. ].

]
