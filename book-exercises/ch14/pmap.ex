defmodule Parallel do
    def pmap(collection, fun) do
        me = self()
        collection
        |> Enum.map(fn (elem) ->
            spawn_link(fn -> (
                # if rem(elem, 2) == 0 do
                #     IO.puts("Waiting for #{elem}")
                #     :timer.sleep(5000)
                # end
                send(me, {self(), fun.(elem)})
                )
            end)
        end)
        |> Enum.map(fn (pid) ->
            receive do {^pid, result} -> result end
        end)
    end
end
