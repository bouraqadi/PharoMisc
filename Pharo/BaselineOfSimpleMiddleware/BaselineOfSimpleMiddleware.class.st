Class {
	#name : 'BaselineOfSimpleMiddleware',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSimpleMiddleware',
	#package : 'BaselineOfSimpleMiddleware'
}

{ #category : 'baselines' }
BaselineOfSimpleMiddleware >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #SimpleMiddleware
	].

]
