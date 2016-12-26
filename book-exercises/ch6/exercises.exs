# ModulesAndFunctions-1
defmodule Times do
  def double(n), do: n * 2

  def triple(n), do: n * 3

  def quadruple(n), do: double(double(n))
end

# ModulesAndFunctions-4
defmodule Sum do
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)
end

# ModulesAndFunctions-5
defmodule Gcd do
  def gcd(x, 0), do: x
  def gcd(x, y), do
end

# ModulesAndFunctions-6
defmodule Guess do
  def guess(actual, low..high) when (low <= high) and (actual in low..high) do
    currentGuess = low + div(high - low, 2)
    IO.puts("Is it #{currentGuess}")
    guess(currentGuess, actual, low..high)
  end

  defp guess(current, actual, _) when current == actual, do: IO.puts(current)
  defp guess(current, actual, _..high) when current < actual, do: guess(actual, (current + 1)..high)
  defp guess(current, actual, low.._) when current > actual, do: guess(actual, low..(current - 1))
end
