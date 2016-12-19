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
