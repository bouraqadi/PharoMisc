Class {
	#name : #BaselineOfEasyUI,
	#superclass : #BaselineOf,
	#category : #BaselineOfEasyUI
}

{ #category : #baselines }
BaselineOfEasyUI >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'PharoMisc'
			with: [ spec repository: 'github://bouraqadi/PharoMisc' ].
		spec package: 'EasyUI' with: [ spec requires: #( 'PharoMisc' ) ] ]
]
