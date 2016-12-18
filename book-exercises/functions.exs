fizzBuzz = fn
  0, 0, _ -> IO.puts("FizzBuzz")
  0, _, _ -> IO.puts("Fizz")
  _, 0, _ -> IO.puts("Buzz")
  arg1, arg2, arg3 -> IO.puts(arg3)
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
