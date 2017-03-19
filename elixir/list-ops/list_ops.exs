defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count_impl(l, 0)
  end
  defp count_impl([], count), do: count
  defp count_impl([h|t], count), do: count_impl(t, count + 1)

  @spec reverse(list) :: list
  def reverse(l) do
    reverse_impl(l, [])
  end
  defp reverse_impl([], result), do: result
  defp reverse_impl([h|t], result), do: reverse_impl(t, [h|result])

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map_impl(l, f, [])
  end
  defp map_impl([], _f, result), do: reverse(result)
  defp map_impl([h|t], f, result), do: map_impl(t, f, [f.(h) | result])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter_impl(l, f, [])
  end
  defp filter_impl([], _f, result), do: reverse(result)
  defp filter_impl([h|t], f, result) do
    case f.(h) do
      true  -> filter_impl(t, f, [h|result])
      false -> filter_impl(t, f, result)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    reverse(a)
    |> append_impl(b)
  end
  defp append_impl([], b), do: b
  defp append_impl([h|t], b), do: append_impl(t, [h|b])

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    concat_impl(ll, [])
    |> reverse()
  end
  defp concat_impl([], result), do: result
  defp concat_impl([h|t], result) do
    case is_list(h) do
      true  -> concat_impl(t, concat_impl(h, result))
      false -> concat_impl(t, [h|result])
    end
  end
end
