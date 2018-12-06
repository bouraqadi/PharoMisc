Class {
	#name : #BaselineOfEquals,
	#superclass : #BaselineOf,
	#category : #BaselineOfEquals
}

{ #category : #baselines }
BaselineOfEquals >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #Equals ].

]
