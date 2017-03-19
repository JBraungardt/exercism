defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _base_a, _base_b), do: nil
  def convert(_digits, base_a, base_b) when base_a <= 1 or base_b <= 1, do: nil
  def convert(digits, base_a, base_b) do
    case Enum.all?(digits, &(&1>=0 and &1<base_a)) do
      true  -> to_base10(digits, base_a)
               |> to_base(base_b, [])
      false -> nil
    end
  end

  defp to_base10(digits, base) do
    Enum.reverse(digits)
    |> Enum.with_index()
    |> Enum.reduce(0, fn({digit, idx}, acc) ->
        digit * :math.pow(base, idx) + acc
      end)
    |> round()
  end

  defp to_base(0, _base, _digits), do: [0]
  defp to_base(number, base, digits) do
    exp = :math.log(number) / :math.log(base)
    |> Float.floor()
    |> round()

    to_base(number, base, digits, exp)
  end

  defp to_base(number, _base, digits, 0) do
     [number | digits]
     |> Enum.reverse()
  end

  defp to_base(number, base, digits, exp) do
    value_at_position = :math.pow(base, exp) |> round()
    digit = div(number, value_at_position)
    to_base(number - (digit * value_at_position), base, [digit | digits], exp-1)
  end

  @doc """
  def from_10(value, base, list) when value < base, do: [value | list]
  def from_10(value, base, list) do
      from_10(div(value, base), base, [rem(value, base) | list])
  end
  """

end
