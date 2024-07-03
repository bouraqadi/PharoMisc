Class {
	#name : 'BaselineOfConcurrency',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfConcurrency',
	#package : 'BaselineOfConcurrency'
}

{ #category : 'baselines' }
BaselineOfConcurrency >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #Concurrency. ].

]
