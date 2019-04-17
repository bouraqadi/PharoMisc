Class {
	#name : #NeTcpServerTest,
	#superclass : #NeTcpSocketTest,
	#instVars : [
		'server'
	],
	#category : #'NetworkExtras-Test'
}

{ #category : #testing }
NeTcpServerTest >> newServer [
	^ NeTcpServer port: NeTcpUsedPortsTracker freePortAtRandom
]

{ #category : #testing }
NeTcpServerTest >> setUp [
	super setUp.
	server := self newServer.
	server priority: Processor userInterruptPriority.
	self startServer
]

{ #category : #testing }
NeTcpServerTest >> startServer [
	server start
]

{ #category : #testing }
NeTcpServerTest >> testStopShouldQuicklyReturn [
	self should: [ server stop ] notTakeMoreThan: 500 milliSeconds 
]
