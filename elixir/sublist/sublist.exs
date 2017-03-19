defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b              -> :equal
      is_sublist?(a, b)    -> :sublist
      is_superlist?(a, b)  -> :superlist
      true                 -> :unequal
    end
  end

  defp is_sublist?([], _b), do: true
  defp is_sublist?(_a, []), do: false
  defp is_sublist?(a, [h|t] = b) do
    sub_b = Enum.slice(b, 0, Enum.count(a))
    cond do
      Enum.count(sub_b) != Enum.count(a) -> false
      a === sub_b                        -> true
      true                               -> is_sublist?(a, t)
    end
  end

  defp is_superlist?(a, b), do: is_sublist?(b, a)
end
