Class {
	#name : #BaselineOfLightweightObserver,
	#superclass : #BaselineOf,
	#category : #BaselineOfLightweightObserver
}

{ #category : #baselines }
BaselineOfLightweightObserver >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #LightweightObserver. ].

]
