Class {
	#name : 'BaselineOfLightweightObserver',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfLightweightObserver',
	#package : 'BaselineOfLightweightObserver'
}

{ #category : 'baselines' }
BaselineOfLightweightObserver >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #LightweightObserver. ].

]
