defmodule Palindromes do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    palindroms =
      for n1 <- min_factor..max_factor,
          n2 <- n1..max_factor,
          is_palindrom(n1 * n2) do
        {n1, n2, n1 * n2}
      end
      |> Enum.sort_by(fn {_, _, number} -> number end)
      |> Enum.chunk_by(fn {_, _, number} -> number end)

    smallest = Enum.at(palindroms, 0)
    largest = Enum.at(palindroms, -1)

    result = %{}
    result = Map.put(result, product(smallest), factors(smallest))
    result = Map.put(result, product(largest), factors(largest))

    result
  end

  defp is_palindrom(number) when is_integer(number) do
    number_str = Integer.to_string(number)

    number_str == String.reverse(number_str)
  end

  defp product(list) do
    {_, _, number} =
      list
      |> hd()

    number
  end

  defp factors(list) do
    Enum.map(list, fn {n1, n2, _} -> [n1, n2] end)
  end
end
