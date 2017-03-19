defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    Regex.replace(~r/\P{L}/u, sentence, "")
    |> String.downcase()
    |> String.graphemes()
    |> Enum.group_by(&(&1))
    |> Enum.into([], fn({_k, values}) -> length(values) end)
    |> Enum.all?(&(&1 == 1))
  end

end
