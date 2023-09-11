Class {
	#name : #BaselineOfPharoMisc,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoMisc
}

{ #category : #baselines }
BaselineOfPharoMisc >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'GitBridge'
			with: [ spec repository: 'github://jecisc/GitBridge' ].
		spec package: 'PharoMisc' with: [ spec requires: #( 'GitBridge' ) ] ]
]
