defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.reduce(input, %{}, &transform_item/2)
  end

  defp transform_item({score, list}, result) do
    Enum.into(list, result, &{String.downcase(&1), score})
  end

  def transform2(input) do
    for {key, list} <- input, word <- list, into: %{} do
      {String.downcase(word), key}
    end
  end
end
