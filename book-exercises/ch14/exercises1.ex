defmodule UniqueToken do
    def repeater() do
        receive do
            {sender, token} ->
                send(sender, {self(), token})
                repeater()
        end
    end

    def run() do
        pid1 = spawn(UniqueToken, :repeater, [])
        pid2 = spawn(UniqueToken, :repeater, [])

        IO.inspect(pid1)
        IO.inspect(pid2)

        send(pid1, {self(), :computer})
        send(pid2, {self(), :coffee_cup})

        receive do
            {sender, :coffee_cup} ->
                IO.puts(":coffee_cup from #{inspect(sender)}")
        end

        receive do
            {sender, :computer} ->
                IO.puts(":computer from #{inspect(sender)}")
        end
    end
end
