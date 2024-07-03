Class {
	#name : 'BaselineOfNetworkExtras',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfNetworkExtras',
	#package : 'BaselineOfNetworkExtras'
}

{ #category : 'baselines' }
BaselineOfNetworkExtras >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: #Concurrency with: [
				spec repository: 'github://bouraqadi/PharoMisc:pharo12'];
			package: #NetNameResolverBugFix;
			package: #NetworkExtras with: [
				spec requires: #(Concurrency NetNameResolverBugFix)
				]. ].

]
