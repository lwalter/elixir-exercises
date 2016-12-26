defmodule Exercises do
  # Sum function
  #
  # Exercises.sum([1, 2, 3]) # => 6

  def sum(list), do: do_sum(list, 0)

  defp do_sum([], total), do: total
  defp do_sum([ head | tail ], total), do: do_sum(tail, head + total)

  # ListsAndRecursion-0

  # ListsAndRecursion-1
  #
  # Exercises.mapsum([1, 2, 3], &(&1 * &2)) # => 14

  def mapsum(list, func) do
    do_mapsum(list, func, 0)
  end

  defp do_mapsum([], _, total), do: total
  defp do_mapsum([ head | tail ], func, total) do
    do_mapsum(tail, func, total + func.(head))
  end

  # ListsAndRecursion-2
  #
  # Exercises.caesar('ryvkve', 13) # =>
  def caesar(list, key) do
    do_caesar(list, key, [])
  end

  defp do_caesar([], _, encrypted_list) do
    encrypted_list
  end
  defp do_caesar([ head | tail], key, encrypted_list) do
    do_caesar(tail, key, encrypted_list ++ [encrypt_char(head, key)])
  end

  defp encrypt_char(char, key) when char + key > ?z do
    char + key - 26
  end
  defp encrypt_char(char, key) do
    char + key
  end
end
