Class {
	#name : 'BaselineOfPharoExtra',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoExtra',
	#package : 'BaselineOfPharoExtra'
}

{ #category : 'baselines' }
BaselineOfPharoExtra >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: #PharoExtra ]
]
