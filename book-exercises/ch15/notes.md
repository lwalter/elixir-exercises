# Ch 15 Nodes - The Key to Distributing Services
* A *node* is simply a running Erlang VM.
* The Erlang VM is called *Beam* which acts as a little operating system running on top of your host operating system.
* This OS handles its own events, process scheduling, memory, naming services and interprocess communication.

## Naming Nodes
* Node.self() returns the name of the given node the code is running on
* A node can be named with a fully qualified name or a short name
    * iex --name \<fully qualified>
    * iex --sname \<short name>
* When short name is used, the machine name is used as well. 
    * iex --sname lnw == lnw@ubuntu-gnome
* Nodes can be connected via ```Node.connect```.
* ```Node.list``` returns the list of connected nodes.
* Code can be spawned on any connected node via ```Node.spawn```

## Node security
* Before a connecting node can complete its connection, it ensures that the remote node has permission to do so.
* Permission is verified by checking the remote nodes *cookie*
* This cookie is just an arbitrary string.
* A cookie can be set by running ```iex -sname node1 --cookie s3cur3c00ki3```
* Nodes can connect to each other on the same machine when no cookie is given because Erlang will look for a ```.erlang.cookie``` file in the home dir. If one is not found, then a random string is generated and placed at that location.
* Be aware that cookies are transmitted in plain text. Connecting nodes over a public network can be dangerous.

## Naming a process
* A PID consists of three numbers, ```<node ID>.<low process ID bit>.<high process ID bit>```
* An application can specify in the *mix.exs* file the list of names that its processes can be named
* It's standard to register process names when an application starts