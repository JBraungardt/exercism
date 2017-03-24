defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number <= 0 or number > 64 do
    { :error, "The requested square must be between 1 and 64 (inclusive)" }
  end
  def square(number) do
    count = generate()
            |> Enum.take(number)
            |> Enum.at(-1)

    {:ok, count}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    generate()
    |> Enum.take(64)
    |> Enum.sum()
  end

  defp generate() do
    Stream.unfold(1, &{&1, &1 * 2})
  end

  #================================================

  # use Bitwise, only_operators: true
  #
  # def square(number) when number > 64 or number < 1, do: {:error, "The requested square must be between 1 and 64 (inclusive)"}
  # def square(number), do: {:ok, 1 <<< number - 1}
  #
  # def total, do: {:ok, (1 <<< 64) - 1}
end
