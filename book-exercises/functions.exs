fizzBuzz = fn
  0, 0, _ -> IO.puts("FizzBuzz")
  0, _, _ -> IO.puts("Fizz")
  _, 0, _ -> IO.puts("Buzz")
  _, _, arg3 -> IO.puts(arg3)
end

doFizzBuzz = fn(n) ->
  fizzBuzz.(rem(n, 3), rem(n, 5), n)
end

doFizzBuzz.(10)
doFizzBuzz.(11)
doFizzBuzz.(12)
doFizzBuzz.(13)
doFizzBuzz.(14)
doFizzBuzz.(15)
doFizzBuzz.(16)

prefix = fn(prefix) ->
   fn(suffix) ->
     "#{prefix} #{suffix}"
   end
 end

 mrs = prefix.("Mrs")
 IO.puts(mrs.("Smith"))
 IO.puts(prefix.("Elixir").("Rocks"))


 Enum.map([1, 2, 3, 4], &(&1 + 2))
 Enum.map([1, 2, 3, 4], &(IO.inspect(&1)))
