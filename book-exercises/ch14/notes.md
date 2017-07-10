# Ch 14 Notes
* Elixir uses *actor* model of concurrency
* Actor is an independent process that shares nothing with any other process.
* Elixir processes are much more lightweight than system processes

## Process overhead
* Use *spawn* to start a new process
* *spawn* returns a *Process Identifier*, PID for short
* Use *send* to send a PID a message (aka  *term*)
* Typically you send atoms and tuples
* Wait for messages using *receive*

## When processes die
* By default, noone gets told when processes die
* The VM knows and can report it to the console, app code must be explicitly told to monitor
* You can have a process propagate death to another one you can link them together via *spawn_link*
* When the child process exits abnormally, it kills the parent as well.
* Two linked processes receive notifications about the other.
* Another technique, *monitoring* lets a process spawn another and be notified of its termination, but without the reverse notification - it is one way only.
* When monitoring, you receive a :DOWN message when it exits for fails, or if it doesnt exist
* *spawn_monitor* turns on monitoring when a process is spawned
* When to use links and when to use monitors?
    * If the intent is that a failure in one process should terminate another, then link
    * If you only need to be aware of when some other process exits for any reason, then monitor