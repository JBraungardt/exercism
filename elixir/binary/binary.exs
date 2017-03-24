defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    if String.match?(string, ~r/[^01]/) do
      0
    else
      String.codepoints(string)
      |> Enum.reverse
      |> Enum.with_index(0)
      |> Enum.reduce(0, fn
          {"1", exp}, result  -> result + :math.pow(2, exp)
          {"0", _exp}, result -> result
        end)
    end
  end
end
