Class {
	#name : #BaselineOfNetworkExtras,
	#superclass : #BaselineOf,
	#category : #BaselineOfNetworkExtras
}

{ #category : #baselines }
BaselineOfNetworkExtras >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			package: #NetworkExtras with: [
				spec requires: #('Concurrency')
				]. ].

]
