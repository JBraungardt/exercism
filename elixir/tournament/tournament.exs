defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.reject(&(&1 == nil))
    |> Enum.reduce(%{}, &process_line(&1, &2))
    |> Map.to_list()
    |> Enum.sort(&order_results/2)
    |> Enum.map(&result_to_stirng/1)
    |> print_result()
  end

  defp parse_line(line) do
    Regex.run(~r/([^;]+);([^;]+);(win|draw|loss)$/, line, capture: :all_but_first)
  end

  defp process_line([team_1, team_2, "win"], result) do
    result
    |> track_win(team_1)
    |> track_loss(team_2)
  end

  defp process_line([team_1, team_2, "loss"], result) do
    result
    |> track_loss(team_1)
    |> track_win(team_2)
  end

  defp process_line([team_1, team_2, "draw"], result) do
    result
    |> track_draw(team_1)
    |> track_draw(team_2)
  end

  defp track_win(result, team) do
    Map.update(result, team, {1, 1, 0, 0, 3}, fn {played, won, draw, lost, points} ->
      {played + 1, won + 1, draw, lost, points + 3}
    end)
  end

  defp track_loss(result, team) do
    Map.update(result, team, {1, 0, 0, 1, 0}, fn {played, won, draw, lost, points} ->
      {played + 1, won, draw, lost + 1, points}
    end)
  end

  defp track_draw(result, team) do
    Map.update(result, team, {1, 0, 1, 0, 1}, fn {played, won, draw, lost, points} ->
      {played + 1, won, draw + 1, lost, points + 1}
    end)
  end

  defp order_results({team_1, {_, _, _, _, points}}, {team_2, {_, _, _, _, points}}) do
    team_1 < team_2
  end

  defp order_results({_, {_, _, _, _, points_1}}, {_, {_, _, _, _, points_2}}) do
    points_1 >= points_2
  end

  defp result_to_stirng({team, {number, won, draw, loss, points}}) do
    "#{pad_team(team)}|  #{number} |  #{won} |  #{draw} |  #{loss} |  #{points}"
  end

  defp print_result(result) do
    "#{pad_team("Team")}| MP |  W |  D |  L |  P\n" <> Enum.join(result, "\n")
  end

  defp pad_team(team) do
    String.pad_trailing(team, 31)
  end
end
