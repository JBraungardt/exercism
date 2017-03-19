defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string)
    |> Enum.flat_map(&abbreviation_for_word/1)
    |> Enum.join()
    |> String.upcase()
  end

  defp abbreviation_for_word(word) do
    {first, rest} = String.next_codepoint(word)

    [first] ++ uppercase_letters(rest)
  end

  defp uppercase_letters(string) do
    String.codepoints(string)
    |> Enum.filter(&(String.match?(&1, ~r/[A-Z]/)))
  end
end
