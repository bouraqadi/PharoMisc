"
I handle main window events received by World.
I quit whenever requested 
"
Class {
	#name : #AmQuitWindowEventsHanlder,
	#superclass : #Object,
	#category : #AppMaker
}

{ #category : #'event handling' }
AmQuitWindowEventsHanlder >> windowEvent: anEvent [
	anEvent type == #windowClose ifTrue: [ 
		SessionManager default snapshot: false andQuit: true].
	
]
