Class {
	#name : #BaselineOfBaselineAnalyzer,
	#superclass : #BaselineOf,
	#category : #BaselineOfBaselineAnalyzer
}

{ #category : #baselines }
BaselineOfBaselineAnalyzer >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
			spec
			package: 'BaselineAnalyzer'
 ]
]
