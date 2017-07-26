defmodule Stack.Server do
  use GenServer

  def handle_call({:init, initial_stack}, _, _) do
    {:reply, initial_stack}
  end

  def handle_call(:pop, _from, current_stack) do
    data = List.pop_at(current_stack, 0)
    popped_value = elem(data, 0)
    new_stack = elem(data, 1)
    {:reply, popped_value, new_stack}
  end
end
