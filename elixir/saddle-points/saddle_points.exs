defmodule Matrix do

  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    create_matirx(str)
    |> Enum.group_by(fn({_col, {r, _c}}) -> r end, fn({elem, _}) -> elem end)
    |> Enum.map(fn({_, row}) -> row end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    create_matirx(str)
    |> Enum.group_by(fn({_col, {_r, c}}) -> c end, fn({elem, _}) -> elem end)
    |> Enum.map(fn({_, row}) -> row end)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    create_matirx(str)
    |> Enum.filter(fn({elem, {r, c}}) ->
        row_to_check = rows(str) |> Enum.at(r)
        col_to_check = columns(str) |> Enum.at(c)

        is_greatest?(elem, row_to_check) and is_smalest?(elem, col_to_check)
      end)
    |> Enum.map(fn({_, pos}) -> pos end)
  end

  defp is_greatest?(elem, list), do: Enum.all?(list, &(&1 <= elem))
  defp is_smalest?(elem, list), do: Enum.all?(list, &(&1 >= elem))

  defp create_matirx(str) do
    String.split(str, "\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn({row, r}) ->
        String.split(row, " ")
        |> Enum.with_index()
        |> Enum.map(fn({elem, c}) ->
            {String.to_integer(elem), {r, c}}
          end)
      end)
  end
end


# defmodule Matrix do
#   @doc """
#   Parses a string representation of a matrix
#   to a list of rows
#   """
#   @spec rows(String.t()) :: [[integer]]
#   def rows(str) do
#     str
#     |> String.split("\n")
#     |> Enum.map(&parse_row/1)
#   end
#
#   defp parse_row(str) do
#     str
#     |> String.split(" ")
#     |> Enum.map(&String.to_integer/1)
#   end
#
#   @doc """
#   Parses a string representation of a matrix
#   to a list of columns
#   """
#   @spec columns(String.t()) :: [[integer]]
#   def columns(str) do
#     rows(str)
#     |> List.zip
#     |> Enum.map(&Tuple.to_list/1)
#   end
#
#   @doc """
#   Calculates all the saddle points from a string
#   representation of a matrix
#   """
#   @spec saddle_points(String.t()) :: [{integer, integer}]
#   def saddle_points(str) do
#     for {r, x} <- Enum.with_index(rows(str)),
#         {c, y} <- Enum.with_index(columns(str)),
#         Enum.max(r) == Enum.min(c),
#         do: {x, y}
#   end
# end
