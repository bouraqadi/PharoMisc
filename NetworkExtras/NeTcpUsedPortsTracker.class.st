"
I track TCP ports  used for reception to avoid having 2 sockets listening on the same port.

I am added to the image start up list to ensure that we start with an empty set of used ports, since we lose the references to system sockets once the image quits.
"
Class {
	#name : #NeTcpUsedPortsTracker,
	#superclass : #NeUsedPortsTracker,
	#traits : 'NeTResetTrackedUsedPortsOnStartUp',
	#classTraits : 'NeTResetTrackedUsedPortsOnStartUp classTrait',
	#category : #'NetworkExtras-Kernel'
}
