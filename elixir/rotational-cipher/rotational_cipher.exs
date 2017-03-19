defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    shift = rem(shift, 26)

    String.to_charlist(text)
    |> Enum.map(fn(char) ->
        cond do
          char >= 65 and char <= 90  -> rotate(char, shift, 65, 90)
          char >= 97 and char <= 122 -> rotate(char, shift, 97, 122)
          true                       -> char
        end
      end)
    |> List.to_string()
  end

  defp rotate(char, shift, lower, upper) when char + shift > upper do
    char + shift - upper + lower - 1
  end
  defp rotate(char, shift, _lower, _upper), do: char + shift
end
