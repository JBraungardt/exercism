defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    flatten_impl(list, [])
    |> Enum.reverse()
  end

  defp flatten_impl([], result), do: result
  defp flatten_impl([h|t], result) when is_list(h) do
    result = flatten_impl(h, result)
    flatten_impl(t, result)
  end
  defp flatten_impl([h|t], result) do
    case h do
      nil -> flatten_impl(t, result)
      _   -> flatten_impl(t, [h|result])
    end
  end
end
