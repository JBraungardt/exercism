defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep([], _), do: []
  def keep(list, fun) do
    do_keep(list, fun, [])
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard([], _), do: []
  def discard(list, fun) do
    do_keep(list, fn(e) -> !fun.(e) end, [])
  end

  defp do_keep([], _fun, result), do: Enum.reverse(result)
  defp do_keep([h | t], fun, res) do
    res = case fun.(h) do
      true -> [h | res]
      _    -> res
    end

    do_keep(t, fun, res)
  end
end
