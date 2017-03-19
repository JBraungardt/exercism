defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(string) do
    encode(string, nil, 0, "")
  end

  defp encode(<<char, rest::binary>>, nil, _count, encoded) do
    #Regex.scan(~r/([A-Za-z\s])\1*/, string)
    encode(rest, <<char>>, 1, encoded)
  end

  defp encode("", last_char, 1, encoded), do: encoded <> last_char
  defp encode("", last_char, count, encoded), do: encoded <> Integer.to_string(count) <> last_char

  defp encode(<<char, rest::binary>>, last_char, count, encoded) when <<char>> == last_char do
    encode(rest, last_char, count + 1, encoded)
  end

  defp encode(<<char, rest::binary>>, last_char, 1, encoded) do
    encoded = encoded <> last_char
    encode(rest, <<char>>, 1, encoded)
  end

  defp encode(<<char, rest::binary>>, last_char, count, encoded) do
    encoded = encoded <> Integer.to_string(count) <> last_char
    encode(rest, <<char>>, 1, encoded)
  end

  @spec decode(String.t) :: String.t
  def decode(string) when is_binary(string) do
    Regex.scan(~r/(\d*)(\P{Cc})/, string, capture: :all_but_first)
    |> Enum.map(&do_decode/1)
    |> Enum.join()
  end

  defp do_decode(["", char]), do: char
  defp do_decode([count, char]) do
    count = String.to_integer(count)
    String.duplicate(char, count)
  end
end
