defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    with {:ok, start} <- NaiveDateTime.new(year, month, day, hours, minutes, seconds),
         t <- NaiveDateTime.add(start, 1_000_000_000, :second),
    do: {{t.year, t.month, t.day}, {t.hour, t.minute, t.second}}
  end
end
