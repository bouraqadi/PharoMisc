"
I lock development menus and shortcuts.
Image is locked so users can only interact via UI kept open. 

To turn a development image into a ready to use desktop app, simply evaluate: 
DesktopAppMaker makeApp
"
Class {
	#name : #AmAppMaker,
	#superclass : #Object,
	#category : #AppMaker
}

{ #category : #'app making' }
AmAppMaker class >> makeApp [
	<script: 'self new makeApp'>
	self new makeApp
]

{ #category : #'app making' }
AmAppMaker >> captureMainWindowEvents [
	World windowEventHandler: AmQuitWindowEventsHanlder new
]

{ #category : #'app making' }
AmAppMaker >> disableDevMenusAndShortcuts [
	KMRepository default: KMRepository new.
	MenubarMorph showMenubar: false.
	"By default World does not have an event handler (used in Morph>>handlesMouseDown:).
	So, PasteUpMorph>>mouseDown: proceeds and shows popup development menu.
	We avoid this by adding an event handler that captures the mouseDown event (see Morph>>on:send:to:)"
	World on: #mouseDown send: #value to: nil.

]

{ #category : #'app making' }
AmAppMaker >> makeApp [
	(self confirm: 'Development tools are about to be disabled. Proceed?') ifFalse: [ ^self ].
	self disableDevMenusAndShortcuts.
	self removeTaskBar.
	self captureMainWindowEvents.
	(self confirm: 'Development tools are now disabled. Save image?') ifFalse: [ ^self ].
	self saveImage
]

{ #category : #'app making' }
AmAppMaker >> removeTaskBar [
	World removeTaskbar
]

{ #category : #'app making' }
AmAppMaker >> saveImage [
	SessionManager default snapshot: true andQuit: false
]
