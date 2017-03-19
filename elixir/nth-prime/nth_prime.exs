defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise("There is no 0th prime!")
  def nth(1), do: 2
  def nth(count) do
    Stream.iterate(2, &(&1+1))
    |> Stream.filter(&is_prime/1)
    |> Enum.take(count - 1)
    |> List.last()
  end

  defp is_prime(number) do
    2..div(number + 1, 2)
    |> Enum.all?(&rem(number, &1) != 0)
  end

end


#def nth(0), do: raise "Count must be greater than 0."
#def nth(count) do
#  Stream.iterate(2, &next_prime/1)
#    |> Enum.take(count)
#    |> List.last
#end
#
#def next_prime(num) do
#  num = num + 1
#
#  if factors_for(num) == [num] do
#    num
#  else
#    next_prime(num)
#  end
#end
#
#def factors_for(number) do
#factors_for(number, 2, [])
#end
#defp factors_for(1, _, factors), do: factors
#defp factors_for(number, n, factors) do
#  if rem(number, n) == 0 do
#    factors_for div(number, n), n, factors ++ [n]
#  else    factors_for number, n + 1, factors  end
#end
