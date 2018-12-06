Class {
	#name : #BaselineOfConcurrency,
	#superclass : #BaselineOf,
	#category : #BaselineOfConcurrency
}

{ #category : #baselines }
BaselineOfConcurrency >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #Concurrency. ].

]
