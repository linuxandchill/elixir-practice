defmodule EulerOne do
  @moduledoc """
  Documentation for Euler Problem #1.
  """

  @doc """
  Gets the sum of numbers between a range that are multiples
  of 3 & 5.

  ## Examples

      iex> EulerOne.getSum(1,9)
      23
  """

  def getSum(a,b) do
    a..b
    |> Stream.filter( &( rem(&1, 3) == 0 || rem(&1,5) == 0) )
    |> Enum.sum
  end
end 
