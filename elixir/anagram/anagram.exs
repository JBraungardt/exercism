defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    letters = to_sorted_list(base)

    Enum.filter(candidates, fn(candidate) ->
        to_test = to_sorted_list(candidate)
        same_letters?(letters, to_test) and not same_case_insensitive?(base, candidate)
      end)
  end

  defp to_sorted_list(str) do
    String.downcase(str)
    |> String.graphemes()
    |> Enum.sort
  end

  defp same_letters?(list1, list2), do: list1 == list2

  defp same_case_insensitive?(str1, str2), do: String.match?(str1, ~r/#{str2}/i)
end
