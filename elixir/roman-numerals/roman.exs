defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    convert(number, "")
  end

  defp convert(0, str), do: str

  defp convert(number, str) when number>=1000, do: convert(number-1000, str <> "M")
  defp convert(number, str) when number>=900,  do: convert(number-900, str <> "CM")
  defp convert(number, str) when number>=500,  do: convert(number-500, str <> "D")
  defp convert(number, str) when number>=400,  do: convert(number-400, str <> "CD")
  defp convert(number, str) when number>=100,  do: convert(number-100, str <> "C")
  defp convert(number, str) when number>=90,   do: convert(number-90, str <> "XC")
  defp convert(number, str) when number>=50,   do: convert(number-50, str <> "L")
  defp convert(number, str) when number>=40,   do: convert(number-40, str <> "XL")
  defp convert(number, str) when number>=10,   do: convert(number-10, str <> "X")
  defp convert(9, str),                        do: convert(0, str <> "IX")
  defp convert(number, str) when number>=5,    do: convert(number-5, str <> "V")
  defp convert(4, str),                        do: convert(0, str <> "IV")
  defp convert(number, str),                   do: convert(number-1, str <> "I")
end
