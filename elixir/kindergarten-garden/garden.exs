defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @default_names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    sorted_students = Enum.sort(student_names)

    grouped_cups = group(info_string)

    assigne_cups(sorted_students, grouped_cups)
  end

  defp group(garden_str) do
    String.split(garden_str, "\n")
    |> Enum.map(&String.graphemes(&1))
    |> Enum.map(&Enum.chunk(&1, 2))
    |> Enum.zip()
    |> Enum.map(fn({l1, l2}) ->
          to_plant_list(l1) ++ to_plant_list(l2)
          |> List.to_tuple()
        end)
  end

  defp assigne_cups(students, cups) do
    Enum.zip(students, cups)
    |> Enum.into(create_garden(students))
  end

  defp create_garden(students) do
    Enum.reduce(students, %{}, &Map.put(&2, &1, {}) )
  end

  defp to_plant_list(list) do
    Enum.map(list, &char_to_plant/1)
  end

  defp char_to_plant(char) do
    case char do
      "G" -> :grass
      "C" -> :clover
      "R" -> :radishes
      "V" -> :violets
    end
  end
end
