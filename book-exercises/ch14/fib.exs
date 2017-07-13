defmodule FibSolver do
    def fib(scheduler) do
        send(scheduler, {:ready, self()})
        receive do
            {:fib, n, client} ->
                send(client, {:answer, n, calc_fib(n), self()})
                fib(scheduler)
            {:shutdown} ->
                exit(:normal)
        end
    end

    defp calc_fib(0) do
        0
    end
    defp calc_fib(1) do
        1
    end
    defp calc_fib(n) do
        calc_fib(n - 1) + calc_fib(n - 2)
    end
end

defmodule Scheduler do
    def run(num_procs, module, func, to_calculate) do
        (1..num_procs)
        |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
        |> schedule_procs(to_calculate, func, [])
    end

    defp schedule_procs(processes, queue, func, results) do
        receive do
            {:ready, pid} when length(queue) > 0 ->
                [next | tail] = queue
                send(pid, {func, next, self()})
                schedule_procs(processes, tail, func, results)

            {ready, pid} ->
                send(pid, {:shutdown})
                if length(processes) > 1 do
                    schedule_procs(List.delete(processes, pid), queue, func, results)
                else
                    Enum.sort(results, fn({n1, _}, {n2, _}) -> n1 <= n2 end)
                end

            {:answer, n, result, _pid} ->
                schedule_procs(processes, queue, func, [{n, result} | results])
        end
    end
end

to_process = [37, 37, 37, 37, 37, 37]

Enum.each(1..10, fn(num_processes) ->
    {time, result} = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, to_process])
    if(num_processes == 1) do
        IO.puts(inspect(result))
        IO.puts "\n # time (s)"
    end
    :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
end)
