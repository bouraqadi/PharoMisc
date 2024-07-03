Class {
	#name : 'BaselineOfBooleanExpressions',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBooleanExpressions',
	#package : 'BaselineOfBooleanExpressions'
}

{ #category : 'baselines' }
BaselineOfBooleanExpressions >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #BooleanExpressions. ].

]
