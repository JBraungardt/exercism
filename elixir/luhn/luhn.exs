defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    String.graphemes(number)
    |> Enum.reverse()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(0)
    |> Enum.map(fn({n, i}) ->
        case rem(i, 2) == 0 do
          true  -> n
          false -> double_number(n)
        end
      end)
    |> Enum.sum()
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    cs = checksum(number)
    rem(cs, 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    case valid?(number) do
      true  -> number
      false -> create_next(number, ?0)
    end
  end

  defp create_next(number, to_test) do
    case valid?(number <> <<to_test>>) do
      true  -> number <> <<to_test>>
      false -> create_next(number, to_test + 1)
    end
  end

  defp double_number(n) do
    case n * 2 do
      r when r > 9 -> r - 9
      r            -> r
    end
  end
end
