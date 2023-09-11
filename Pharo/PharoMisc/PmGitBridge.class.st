"
Gives access to PharoMisc Reopo properties and folder
"
Class {
	#name : #PmGitBridge,
	#superclass : #GitBridge,
	#category : #PharoMisc
}

{ #category : #accessing }
PmGitBridge class >> resourcesFolder [

	^ self root / 'Resources'
]
