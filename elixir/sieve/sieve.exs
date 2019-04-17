defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    do_filter(2..limit, 2)
  end

  def do_filter(range, nil), do: range

  def do_filter(range, unmark) do
    filtered = Enum.reject(range, &(rem(&1, unmark) == 0 and &1 != unmark))

    next_unmark = Enum.find(filtered, &(&1 > unmark))

    do_filter(filtered, next_unmark)
  end
end
