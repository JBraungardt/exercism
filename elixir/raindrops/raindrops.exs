defmodule Raindrops do
  @drops %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    @drops
    |> Enum.filter_map(fn({divisor, _}) -> is_factor?(number, divisor) end,
                       fn({_, sound}) -> sound end)
    |> Enum.join()
    |> output(number)
  end

  defp is_factor?(number, divisor) do
    rem(number, divisor) == 0
  end

  defp output("", number), do: Integer.to_string(number)
  defp output(str, _number), do: str
end
