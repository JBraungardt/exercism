defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    max_factor = :math.sqrt(number) |> trunc()
    calc_factors(number, 2, max_factor, [])
  end

  defp calc_factors(1, _factor, _max_factor, factors), do: Enum.reverse(factors)
  defp calc_factors(number, factor, max_factor, factors) when factor > max_factor do
    Enum.reverse([number | factors])
  end
  defp calc_factors(number, factor, max_factor, factors) do
    case rem(number, factor) == 0 do
      true  -> number = div(number, factor)
               max_factor = :math.sqrt(number) |> trunc()
               calc_factors(number, factor, max_factor, [factor | factors])
      false -> calc_factors(number, factor + 1, max_factor, factors)
    end
  end

end
