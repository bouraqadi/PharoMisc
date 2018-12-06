# NetworkExtras
Provides classes that wrap the basic sockets to ease networking

# Install
```Smalltalk
Metacello new
  baseline: 'NetworkExtras';
  repository: 'github://bouraqadi/PharoMisc';
  load
```

# Usage
There exist dedicated classes for each kind of socket
- UDP Broadcast: `NeBroadcastSocket`
- UDP Multicast: `NeMulticastSocket`
- ...

IP ports are tracked to avoid creating multiple servers on the same port.
Finalization ensures that servers are shut down upon garbage collection and release used ports.

