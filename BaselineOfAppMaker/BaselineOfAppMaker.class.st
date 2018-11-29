Class {
	#name : #BaselineOfAppMaker,
	#superclass : #BaselineOf,
	#category : #BaselineOfAppMaker
}

{ #category : #baselines }
BaselineOfAppMaker >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #AppMaker. ].

]
