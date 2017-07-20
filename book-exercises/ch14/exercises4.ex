defmodule MultipleProcs4 do
    import :timer, only: [sleep: 1]

    def sender(parent) do
        send(parent, "Hello")
        exit("Oops")
    end

    def loop_receive() do
        receive do
            message ->
                IO.puts("Messsage: #{inspect(message)}")
                loop_receive()
        after 500 ->
            IO.puts("All messagess received")
        end
    end

    def run() do
        spawn_monitor(MultipleProcs4, :sender, [self()])
        sleep(500)
        loop_receive()
    end
end
