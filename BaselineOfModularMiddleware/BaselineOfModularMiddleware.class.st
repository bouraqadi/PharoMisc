Class {
	#name : #BaselineOfModularMiddleware,
	#superclass : #BaselineOf,
	#category : #BaselineOfModularMiddleware
}

{ #category : #baselines }
BaselineOfModularMiddleware >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			repository: 'github://bouraqadi/PharoMisc';
			package: #ModularMiddleware
	].

]
