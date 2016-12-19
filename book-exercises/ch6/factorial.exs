defmodule Factorial do
  def f(0), do: 1
  def f(n) when n > 0 do
    n * f(n - 1)
  end
end
