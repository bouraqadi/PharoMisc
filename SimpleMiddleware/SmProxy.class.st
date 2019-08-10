"
I am the placeholder of a remote object. Whenever I receive a message and forward it to the remote object through a socket using the protocol. Forwarded message is converted to a remote message.

    Instance Variables
	identifier:		<Object> identifier of the remote object
	ip:		<String> Hostname or Ip of the host of the remote object
	port:		<Number> port number at which listens the server that gives access tothe remote object 
	protocol:		<SmProtocol> Converts  message to bytes and response byte to an actual object.

"
Class {
	#name : #SmProxy,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'identifier',
		'protocol'
	],
	#category : #'SimpleMiddleware-Kernel'
}

{ #category : #'instance creation' }
SmProxy class >> ip: newIp port: newPort identifier: id protocol: aProtocol [
	^self new
		ip: newIp port: newPort identifier: id protocol: aProtocol;
		yourself
]

{ #category : #marshalling }
SmProxy >> doMarshallingWith: marshaller [
	^marshaller marshallProxyIp: ip port: port identifier: identifier.
]

{ #category : #communication }
SmProxy >> doesNotUnderstand: aMessage [
	| socketStream remoteMessage response |
	remoteMessage := SmRemoteMessage receiverId: identifier selector: aMessage selector arguments: aMessage arguments.
	socketStream := SocketStream 
								openConnectionToHostNamed: ip
								port: port.
	[
		protocol writeObject: remoteMessage into: socketStream.
		response := protocol readObjectFrom: socketStream.
	] ensure: [socketStream close].
	^response.

]

{ #category : #'initialize-release' }
SmProxy >> ip: aString port: anInteger identifier: id protocol: aProtocol [
	ip := aString.
	port := anInteger.
	identifier := id.
	protocol := aProtocol.
]
