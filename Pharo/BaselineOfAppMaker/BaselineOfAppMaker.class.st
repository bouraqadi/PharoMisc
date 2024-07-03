Class {
	#name : 'BaselineOfAppMaker',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAppMaker',
	#package : 'BaselineOfAppMaker'
}

{ #category : 'baselines' }
BaselineOfAppMaker >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #AppMaker. ].

]
