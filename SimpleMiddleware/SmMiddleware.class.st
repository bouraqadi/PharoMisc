"
I am the facade of a middleware.  I allow to export objects i.e. make them available for remote communications. I also allow building proxies on remote objects, i.e. object exported by other middlewares.

Public API and Key Messages
- export: anObject as: id 
Export anObject and makes it remotely identifiable using the given id.
-proxyIp: aString port: anInteger identifier: id 
 Answers a proxy of some remote object identifiable using the given id.
 
I act as a factory to build and connect all elements of a middleware.

    Instance Variables
	dispatcher:		<SmDispatcher> dispatches remote messages to their target objects
	marshaller:		<SmMarshaller> replaces objects by placeholders and vice-versa to ensure using the right objects on each middleware and avoid duplications.
	protocol:		<SmProtocol> In charge of serialization and materialization. Knows the structure of streams of bytes sent over the nework .
	server:		<SmServer> Handles incoming communications over the network.


"
Class {
	#name : #SmMiddleware,
	#superclass : #Object,
	#instVars : [
		'server',
		'dispatcher',
		'protocol',
		'marshaller'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #'instance creation' }
SmMiddleware class >> port: aNumber [
	^self new 
		port: aNumber;
		yourself.
]

{ #category : #accessing }
SmMiddleware >> dispatcher [
	^ dispatcher
]

{ #category : #'initialize-release' }
SmMiddleware >> dispatcherClass [
	^SmDispatcher
]

{ #category : #exporting }
SmMiddleware >> export: anObject as: id [ 
	self dispatcher export: anObject as: id.
]

{ #category : #'initialize-release' }
SmMiddleware >> initialize [
	super initialize.
	dispatcher := self dispatcherClass new.
	marshaller := self marshallerClass new.
	protocol := self protocolClass new.	
	server := self serverClass new.

	protocol marshaller: marshaller.
	marshaller dispatcher: dispatcher.
	marshaller server: server.
	marshaller protocol: protocol.
	server protocol: protocol.
	server dispatcher: dispatcher.
	
]

{ #category : #accessing }
SmMiddleware >> ip [
	^self server ip
]

{ #category : #'initialize-release' }
SmMiddleware >> ip: aString [
	self server ip: aString.

]

{ #category : #'initialize-release' }
SmMiddleware >> ip: aString port: aNumber [
	self ip: aString.
	self port: aNumber.
]

{ #category : #testing }
SmMiddleware >> isStarted [
	^server isStarted
]

{ #category : #accessing }
SmMiddleware >> marshaller [
	^ marshaller
]

{ #category : #'initialize-release' }
SmMiddleware >> marshallerClass [
	^SmMarshaller
]

{ #category : #accessing }
SmMiddleware >> port [
	^self server port
]

{ #category : #'initialize-release' }
SmMiddleware >> port: anInteger [ 
	self server port: anInteger.
]

{ #category : #accessing }
SmMiddleware >> protocol [
	^ protocol
]

{ #category : #'initialize-release' }
SmMiddleware >> protocolClass [
	^SmProtocol
]

{ #category : #proxies }
SmMiddleware >> proxyIp: aString port: anInteger identifier: id [ 
	^self marshaller proxyIp: aString port: anInteger identifier: id.
]

{ #category : #accessing }
SmMiddleware >> server [
	^ server
]

{ #category : #'initialize-release' }
SmMiddleware >> serverClass [
	^SmServer
]

{ #category : #activity }
SmMiddleware >> start [
	^server start
]

{ #category : #activity }
SmMiddleware >> stop [
	^server stop
]
