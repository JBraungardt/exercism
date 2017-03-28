defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Enum.map_reduce(1..num, [], fn(_, acc) ->
      next = calc_next_row(acc)
      {next, next}
    end )
    |> elem(0)
  end

  def calc_next_row(row) do
    [1] ++ (Enum.chunk(row, 2, 1, [])
            |> Enum.map(&Enum.sum(&1)))
  end
end
