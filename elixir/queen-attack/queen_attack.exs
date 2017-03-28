defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0,3}, black \\ {7,3})
  def new({r,c}, {r,c}), do: raise(ArgumentError)
  def new(white, black) do
    %Queens{white: white, black: black}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    for r <- 0..7,
        c <- 0..7
    do
      cell_str({r, c}, queens) <> spacing(c)
    end
    |> Enum.join()
    |> String.trim()

  end

  defp cell_str(cell, %Queens{white: white, black: black}) do
    case cell do
      ^black -> "B"
      ^white -> "W"
      _      -> "_"
    end
  end

  defp spacing(7), do: "\n"
  defp spacing(_), do: " "

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {r1, c}, white: {r2, c}}), do: true
  def can_attack?(%Queens{black: {r, c1}, white: {r, c2}}), do: true
  def can_attack?(%Queens{black: {r1, c1}, white: {r2, c2}}) do
    dif_r = abs(r2 - r1)
    dif_c = abs(c2 - c1)

    dif_r == dif_c
  end
end
