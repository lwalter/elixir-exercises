# Ch 16
## OTP : Servers
* OTP stands for Open Telecom Platform
    * Mostly due to historical interest since it was originally used for telephone exchanges and switches
* OTP is contains Erlang, *Mnesia* (a database), and many libraries.
* It defines a structure for you applications

## Some OTP Defns
* OTP defines systems in terms of hierarchies of *applications*
* Applications consist of one or more processes, which follow a set of OTP conventions, called *behaviors*
* *GenServer* is on such behavior, a server behavior
* A *supervisor* behavior monitors the health of processes and can restart them.