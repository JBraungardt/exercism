defmodule SecretHandshake do
  use Bitwise

  @codes [
    {0b1,    "wink"},
    {0b10,   "double blink"},
    {0b100,  "close your eyes"},
    {0b1000, "jump"}
  ]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Enum.reduce(@codes, [], &add_command(code, &1, &2))
    |> reverse(code)
  end

  defp add_command(code, {command, str}, commands) when (code &&& command) == command do
    commands ++ [str]
  end

  defp add_command(_, _, commands), do: commands

  defp reverse(commands, code) when (code &&& 0b10000) == 0b10000, do: Enum.reverse(commands)
  defp reverse(commands, _), do: commands

end
