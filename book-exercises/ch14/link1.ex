defmodule Link1 do
    import :timer, only: [sleep: 1]

    def sad_function() do
        sleep(500)
        exit(:boom)
    end

    def run() do
        Process.flag(:trap_exit, true)
        spawn(Link1, :sad_function, [])

        receive do
            msg ->
                IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
        after 1000 ->
            IO.puts("Nothing happened after 1 second")
        end
    end
end
