defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> remove_punctuation()
    |> replace_underscore()
    |> String.split()
    |> Enum.reduce(%{}, fn(word, acc) ->
          Map.update(acc, word, 1, &(&1 + 1))
        end)
  end

  @spec remove_punctuation(String.t) :: String.t
  defp remove_punctuation(input) do
    String.replace(input, ~r/[:!&@$%^&,]/, "")
  end

  @spec replace_underscore(String.t) :: String.t
  defp replace_underscore(input) do
    String.replace(input, "_", " ")
  end
end
