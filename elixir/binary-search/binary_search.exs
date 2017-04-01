defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    Tuple.to_list(numbers)
    |> Enum.with_index()
    |> do_search(key)
  end

  defp do_search([], _key), do: :not_found
  defp do_search(numbers, key) do
    idx = round(length(numbers) / 2) - 1
    {number, pos} = Enum.at(numbers, idx)

    cond do
      number == key -> {:ok, pos}
      number > key  -> do_search(Enum.slice(numbers, 0..idx-1), key)
      number < key  -> do_search(Enum.slice(numbers, idx+1..-1), key)
    end
  end
end
