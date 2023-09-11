Class {
	#name : #BaselineOfPharoExtra,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoExtra
}

{ #category : #baselines }
BaselineOfPharoExtra >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #PharoExtra. ].

]
