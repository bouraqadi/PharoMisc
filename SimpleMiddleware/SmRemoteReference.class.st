"
I represent a reference to a remote object. During marshalling/unmarshalling, I am replaced either by a proxy or by a local object.

    Instance Variables
	identifier:		<Object> id of the remote object as defined when exporting the object. 
	ip:		<String> Hostname or Ip string of the host of the remote object
	port:		<Integer> Port number of the server that gives access to the remote object

"
Class {
	#name : #SmRemoteReference,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'identifier'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #'instance creation' }
SmRemoteReference class >> ip: newIp port: newPort identifier: id [
	^self new
		ip: newIp port: newPort identifier: id;
		yourself
]

{ #category : #equality }
SmRemoteReference >> = otherRef [
	^self identifier = otherRef identifier and: [
		self ip = otherRef ip and: [ 
			self port = otherRef port ]  ]
]

{ #category : #unmarshalling }
SmRemoteReference >> doUnmarshallingWith: marshaller [
	^marshaller unmarshallRemoteRefenrence: self
]

{ #category : #equality }
SmRemoteReference >> hash [
	^self identifier hash bitXor: (self ip hash bitXor: self port hash)
]

{ #category : #accessing }
SmRemoteReference >> identifier [
	^ identifier
]

{ #category : #accessing }
SmRemoteReference >> ip [
	^ ip
]

{ #category : #'initialize-release' }
SmRemoteReference >> ip: newIp port: newPort identifier: id [
	ip := newIp.
	port := newPort.
	identifier := id.

]

{ #category : #accessing }
SmRemoteReference >> port [
	^ port
]
