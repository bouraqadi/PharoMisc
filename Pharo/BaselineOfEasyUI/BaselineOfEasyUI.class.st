Class {
	#name : 'BaselineOfEasyUI',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfEasyUI',
	#package : 'BaselineOfEasyUI'
}

{ #category : 'baselines' }
BaselineOfEasyUI >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'PharoMisc'
			with: [ spec repository: 'github://bouraqadi/PharoMisc:pharo12' ].
		spec package: 'EasyUI' with: [ spec requires: #( 'PharoMisc' ) ] ]
]
