defmodule Monitor1 do
    import :timer, only: [sleep: 1]

    def sad_method() do
        sleep(500)
        exit(:boom)
    end

    def run() do
        res = spawn_monitor(Monitor1, :sad_method, [])
        IO.inspect(res)
        
        receive do
            msg ->
                IO.puts("MESSAGE RECEIVED: #{inspect(msg)}")
        after 1000 ->
            IO.puts("Nothing happened after 1 second")
        end
    
    end
end