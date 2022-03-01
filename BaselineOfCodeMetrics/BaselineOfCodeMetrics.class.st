Class {
	#name : #BaselineOfCodeMetrics,
	#superclass : #BaselineOf,
	#category : #BaselineOfCodeMetrics
}

{ #category : #baselines }
BaselineOfCodeMetrics >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			package: #CodeMetrics;
			package: 'CodeMetrics-Tests' with: [ spec requires: #(CodeMetrics) ]
	].

]
