defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str = String.replace(str, ~r/[^{}()[\]]/, "")
    balanced?(String.codepoints(str), [])
  end

  defp balanced?([], []), do: true
  defp balanced?([], state), do: false

  defp balanced?([h|t], []), do: balanced?(t, [h])

  defp balanced?([")"|t1], ["("|t2]), do: balanced?(t1, t2)
  defp balanced?(["]"|t1], ["["|t2]), do: balanced?(t1, t2)
  defp balanced?(["}"|t1], ["{"|t2]), do: balanced?(t1, t2)

  defp balanced?([h1|t1], state), do: balanced?(t1, [h1|state])
end


#defmodule BracketPush do
#  @doc """
#  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
#  """
#  @spec check_brackets(String.t) :: boolean
#  def check_brackets(str), do: check(str, [])
#
#  for {open, close} <- [{?(, ?)}, {?[, ?]}, {?{, ?}}, {?<, ?>}] do
#    # open: stack
#    defp check(<< unquote(open)::utf8, rest::binary >>, acc), do: check(rest, [unquote(close) | acc])
#    # close: unstack
#    defp check(<< unquote(close)::utf8, rest::binary >>, [unquote(close)|acc]), do: check(rest, acc)
#    # close: unstackacable -> unbalanced
#    defp check(<< unquote(close)::utf8, _::binary >>, _), do: false
#  end
#  # discard other chars
#  defp check(<<_::utf8, rest::binary >>, acc), do: check(rest, acc)
#  # balanced
#  defp check(<<>>, []), do: true
#  # unbalanced, opened bracket in stack
#  defp check(<<>>, _), do: false
#end
