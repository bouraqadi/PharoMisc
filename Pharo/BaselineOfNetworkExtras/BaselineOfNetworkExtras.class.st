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
			baseline: #Concurrency with: [
				spec repository: 'github://bouraqadi/PharoMisc'];
			package: #NetNameResolverBugFix;
			package: #NetworkExtras with: [
				spec requires: #(Concurrency NetNameResolverBugFix)
				]. ].

]
