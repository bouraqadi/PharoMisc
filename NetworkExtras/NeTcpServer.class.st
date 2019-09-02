Class {
	#name : #NeTcpServer,
	#superclass : #NeServer,
	#instVars : [
		'port',
		'backlogSize',
		'communicationHandlingBlock',
		'communicationHandlingPriority'
	],
	#category : #'NetworkExtras-TCP-Kernel'
}

{ #category : #'instance creation' }
NeTcpServer class >> port: portNumber [
	^self new
		port: portNumber;
		yourself
]

{ #category : #accessing }
NeTcpServer >> backlogSize [
	^ backlogSize
]

{ #category : #accessing }
NeTcpServer >> backlogSize: anObject [
	backlogSize := anObject
]

{ #category : #accessing }
NeTcpServer >> communicationHandlingPriority [
	^ communicationHandlingPriority
]

{ #category : #accessing }
NeTcpServer >> communicationHandlingPriority: anObject [
	communicationHandlingPriority := anObject
]

{ #category : #'initialize-release' }
NeTcpServer >> defaultBacklogSize [
	^10
]

{ #category : #'initialize-release' }
NeTcpServer >> defaultCommunicationHandlingBlock [
	| data |
	^ [ :socketStream | 
	Transcript
		cr;
		show: self printString;
		show: ' - ';
		show: 'Connection established';
		cr.
	[ 
		socketStream socketWaitForData.
		[ socketStream isDataAvailable ] whileTrue: [ 
			data := socketStream next.
			Transcript show: data asCharacter] 
	] on: Error
	  do: [ Transcript
				cr;
				show: self printString;
				show: ' - ';
				show: 'Communication error' ].
	socketStream closeAndDestroy.
	Transcript
		cr;
		show: self printString;
		show: ' - ';
		show: 'Connection closed';
		cr.
	]

]

{ #category : #'initialize-release' }
NeTcpServer >> defaultCommunicationHandlingPriority [
	^Processor userBackgroundPriority
]

{ #category : #'initialize-release' }
NeTcpServer >> defaultServerName [
	^'TCP Server'
]

{ #category : #'initialize-release' }
NeTcpServer >> initialize [
	super initialize.
	self backlogSize: self defaultBacklogSize.
	communicationHandlingBlock := self defaultCommunicationHandlingBlock.
	self communicationHandlingPriority: self defaultCommunicationHandlingPriority
]

{ #category : #activity }
NeTcpServer >> newSocket [
	^NeTcpSocket listenOnPort: self port backlogSize: self backlogSize
]

{ #category : #accessing }
NeTcpServer >> port [
	^ port
]

{ #category : #accessing }
NeTcpServer >> port: anObject [
	port := anObject
]

{ #category : #activity }
NeTcpServer >> secondsToWaitForConnection [
	^1
]

{ #category : #activity }
NeTcpServer >> servingStep [
	| communicationSocket communicationStream |
	communicationSocket := socket waitForAcceptFor: self secondsToWaitForConnection ifTimedOut: [ ^self ].
	communicationStream := ZdcSocketStream on: communicationSocket.
	[communicationHandlingBlock cull: communicationStream] forkAt: self communicationHandlingPriority
]

{ #category : #activity }
NeTcpServer >> withCommunicationStreamDo: aBlock [
	communicationHandlingBlock := aBlock
]
