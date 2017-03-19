defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    Task.async_stream(texts, &count_letters/1, max_concurrency: workers)
    |> combine_results()
  end

  defp count_letters(text) do
    text = String.downcase(text)
           |> String.replace(~r/\P{L}/u, "")
           |> String.graphemes()
           |> Enum.sort()
           |> Enum.join()

    Regex.scan(~r/(\p{L})\1*/u, text, capture: :first)
    |> List.flatten()
    |> Enum.into(%{}, &{String.first(&1), String.length(&1)})
  end


  defp combine_results(partial_results) do
    Enum.reduce(partial_results, %{}, fn({:ok, partial_result}, result) ->
        Map.merge(result, partial_result, fn(_k, v1, v2) -> v1 + v2 end)
      end)
  end

end
