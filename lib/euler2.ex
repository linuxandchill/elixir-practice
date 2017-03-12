defmodule EulerTwo do 
  @moduledoc """
  Documentation for Euler Problem #2.
  """

even? = fn val -> rem(val, 2) == 0 end
not_over? = fn val, max -> val <= max end

fibs =
  Stream.unfold({1, 2}, fn {a, b} -> {a, {b, a + b}} end)
  |> Stream.filter(even?)
  |> Stream.take_while(&(not_over?.(&1, 4_000_000)))
  |> Enum.to_list

IO.inspect(fibs)
IO.inspect(Enum.sum(fibs))

end 
