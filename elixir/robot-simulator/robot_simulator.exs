defmodule Robot do
  defstruct direction: :north,
            position: {0, 0}
end

defmodule RobotSimulator do
  @valid_directions [:north, :east, :south, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      not valid_direction?(direction) -> { :error, "invalid direction" }
      not valid_position?(position)   -> { :error, "invalid position" }
      true                            -> %Robot{direction: direction, position: position}
    end
  end

  defp valid_direction?(direction) do
    Enum.member?(@valid_directions, direction)
  end

  defp valid_position?({x, y}) when is_integer(x) and is_integer(y), do: true
  defp valid_position?(position), do: false

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    with true             <- valid_instrucions?(instructions),
         %Robot{} = robot <- do_simulate(robot, instructions)
    do
      robot
    else
      _ -> { :error, "invalid instruction" }
    end
  end

  defp valid_instrucions?(instructions) do
    String.match?(instructions, ~r/^[LRA]*$/)
  end

  defp do_simulate(robot, instructions) do
    String.codepoints(instructions)
    |> Enum.reduce(robot, fn(order, robot) ->
        case order do
            "R" -> turn_right(robot)
            "L" -> turn_left(robot)
            "A" -> advance(robot)
        end
      end)
  end

  defp turn_right(%Robot{direction: direction} = robot) do
    case direction do
      :north -> %{robot | direction: :east}
      :east  -> %{robot | direction: :south}
      :south -> %{robot | direction: :west}
      :west  -> %{robot | direction: :north}
    end
  end

  defp turn_left(%Robot{direction: direction} = robot) do
    case direction do
      :north -> %{robot | direction: :west}
      :east  -> %{robot | direction: :north}
      :south -> %{robot | direction: :east}
      :west  -> %{robot | direction: :south}
    end
  end

  defp advance(%Robot{direction: direction, position: {x, y}} = robot) do
    case direction do
      :north -> %{robot | position: {x, y + 1}}
      :east  -> %{robot | position: {x + 1, y}}
      :south -> %{robot | position: {x, y - 1}}
      :west  -> %{robot | position: {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%Robot{direction: direction}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(%Robot{position: position}) do
    position
  end
end
