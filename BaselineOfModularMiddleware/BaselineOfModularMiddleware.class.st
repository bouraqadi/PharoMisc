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
			baseline: 'Equals' with: [
				spec
					repository: 'github://bouraqadi/PharoMisc' ].

		spec 
			repository: 'github://bouraqadi/PharoMisc';
			package: #ModularMiddleware with: [
				spec requires: #('Equals')]
	].

]
