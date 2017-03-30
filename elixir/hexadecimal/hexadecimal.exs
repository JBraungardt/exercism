defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """
  @numbers %{
    "0" => 0,
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "a" => 10,
    "b" => 11,
    "c" => 12,
    "d" => 13,
    "e" => 14,
    "f" => 15
  }

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    valid =
      String.downcase(hex)
      |> String.match?(~r/^[\da-f]*$/)

      to_decimal(hex, valid)
  end

  defp to_decimal(_hex, false), do: 0
  defp to_decimal(hex, true) do
    String.downcase(hex)
    |> String.codepoints()
    |> Enum.reduce(0, &(&2*16 + @numbers[&1]))
  end


  # def to_decimal(hex) do
  #   hex
  #   |> String.downcase
  #   |> String.to_charlist
  #   |> Enum.reduce_while(0, &reducer/2)
  # end
  #
  # defp reducer(c, acc) when c in ?0..?9 or c in ?a..?f do
  #   d = cond do
  #     c in ?0..?9 -> c - ?0
  #     c in ?a..?f -> c - ?a + 10
  #   end
  #   {:cont, acc * 16 + d}
  # end
  #
  # defp reducer(_, _), do: {:halt, 0}
end
