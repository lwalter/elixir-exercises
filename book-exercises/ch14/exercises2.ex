defmodule MultipleProcs2 do
    import :timer, only: [sleep: 1]

    def sender(parent) do
        send(parent, "Hello")
        #exit(:whoops)
    end

    def loop_receive() do
        receive do
            message ->
                IO.puts("Messsage: #{message}")
                loop_receive()
        after 500 ->
            IO.puts("All messagess received")
        end
    end
    
    def run() do
        spawn_link(MultipleProcs2, :sender, [self()])
        sleep(500)
        loop_receive()
    end
end