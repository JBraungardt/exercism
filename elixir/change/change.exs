defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, []), do: :error
  def generate(amount, values) do
    coins = Enum.sort(values, &(&1 >= &2))
    cond do
      amount < smallest_coin(values) -> :error
      true -> generate_impl(amount, coins, Enum.into(values, %{}, &{&1, 0}))
    end
  end

  defp generate_impl(0, _coins, result), do: {:ok, result}
  defp generate_impl(amount, coins, result) do
    case biggest_possible_coin(amount, coins) do
      nil  -> :error
      coin -> generate_impl(amount - coin, coins, Map.update!(result, coin, &(&1 + 1)))
    end
  end

  defp smallest_coin(coins) do
    Enum.sort(coins)
    |> Enum.at(0)
  end

  defp biggest_possible_coin(amount, coins) do
    Enum.find(coins, fn(coin) ->
        amount >= coin and
        (amount == coin or amount - coin >= smallest_coin(coins))
      end)
  end
end
