defmodule Scrabble do

  @score [
    {["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], 1},
    {["D", "G"], 2},
    {["B", "C", "M", "P"], 3},
    {["F", "H", "V", "W", "Y"], 4},
    {["K"], 5},
    {["J", "X"], 8},
    {["Q", "Z"], 10}
  ]

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    String.upcase(word)
    |> String.codepoints()
    |> Enum.reduce(0, &add_points_for_char/2)
  end

  defp add_points_for_char(char, points) do
    points + points_for_char(char)
  end

  defp points_for_char(char) do
    Enum.find_value(@score, 0, fn({chars, worth}) ->
      case Enum.member?(chars, char) do
        true  -> worth
        false -> nil
      end
    end)
  end
end
