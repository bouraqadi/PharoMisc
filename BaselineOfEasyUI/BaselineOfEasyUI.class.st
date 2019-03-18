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
			baseline: 'Roassal3' with: [
				spec repository: 'github://ObjectProfile/Roassal3/src'].
		spec 
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #EasyUI with: [ spec requires: 'Roassal3' ] ].

]
