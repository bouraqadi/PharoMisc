Class {
	#name : #BaselineOfSimpleMiddleware,
	#superclass : #BaselineOf,
	#category : #BaselineOfSimpleMiddleware
}

{ #category : #baselines }
BaselineOfSimpleMiddleware >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			repository: 'github://bouraqadi/PharoMisc';
			package: #SimpleMiddleware
	].

]
