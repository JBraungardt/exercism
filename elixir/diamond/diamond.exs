defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    rows = (letter - ?A) * 2 + 1
    next_row(?A, 0, div(rows, 2), rows, "")
  end

  defp next_row(_letter, row, _col, num_rows, result) when row == num_rows, do: result
  defp next_row(letter,  row, col, num_rows, result) do
    result = result <>
      build_row(letter, num_rows, col)

    {next_letter, next_col} = case row < (num_rows / 2) - 1 do
      true -> {letter + 1, col + 1}
      false -> {letter - 1, col - 1}
    end

    next_row(next_letter, row + 1, next_col, num_rows, result)
  end

  defp build_row(letter, size, col) do
    List.duplicate(" ", size)
    |> List.replace_at(col, <<letter>>)
    |> List.replace_at(-1-col, <<letter>>)
    |> Enum.join()
    |> String.replace_suffix("", "\n")
  end
end
