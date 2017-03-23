defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth


  @day%{
    1 => :monday,
    2 => :tuesday,
    3 => :wednesday,
    4 => :thursday,
    5 => :friday,
    6 => :saturday,
    7 => :sunday
  }
  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    day = 1..Calendar.ISO.days_in_month(year, month)
          |> Enum.map(fn(day) -> day_number_to_name(Calendar.ISO.day_of_week(year, month, day)) end)
          |> Enum.with_index(1)
          |> Enum.filter(fn({day_name, _day}) -> day_name == weekday end)
          |> find_day(schedule)
          |> elem(1)

    {year, month, day}
  end

  defp day_number_to_name(day_number), do: @day[day_number]

  defp find_day(days, schedule) when schedule == :teenth do
    Enum.find(days, fn({_weekday, day}) -> day > 12 end)
  end

  defp find_day(days, schedule) do
    {:ok, day} = Enum.fetch(days, schedule_to_index(schedule))
    day
  end

  defp schedule_to_index(schedule) do
    case schedule do
      :first  -> 0
      :second -> 1
      :third  -> 2
      :fourth -> 3
      :last   -> -1
    end
  end
end
