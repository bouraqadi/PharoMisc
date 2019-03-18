Class {
	#name : #BaselineOfEasyUI,
	#superclass : #BaselineOf,
	#category : #BaselineOfEasyUI
}

{ #category : #baselines }
BaselineOfEasyUI >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			repository: 'github://ObjectProfile/Roassal3/src';
			package: 'Roassal3'.
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #EasyUI with: [ spec requires: 'Roassal3' ] ].

]
