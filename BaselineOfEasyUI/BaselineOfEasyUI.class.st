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
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #EasyUI. ].

]
