defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {nil, :start}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    calc_lenght(list, 0)
  end
  defp calc_lenght({_, :start}, lenght), do: lenght
  defp calc_lenght({_, next}, length), do: calc_lenght(next, length + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    LinkedList.length(list) == 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    case list do
      {_elem, :start} -> {:error, :empty_list}
      {elem, _next}   -> {:ok, elem}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    case list do
      {_elem, :start} -> {:error, :empty_list}
      {_elem, next}   -> {:ok, next}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    case list do
      {_elem, :start} -> {:error, :empty_list}
      {elem, next}   -> {:ok, elem, next}
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    Enum.reverse(list)
    |> Enum.reduce(LinkedList.new(), &push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    consturct_list(list, [])
    |> Enum.reverse()
  end
  defp consturct_list({_, :start}, result), do: result
  defp consturct_list({elem, next}, result) do
    consturct_list(next, [elem | result])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    do_reverse(list, LinkedList.new())
  end
  defp do_reverse({_, :start}, result), do: result
  defp do_reverse({elem, next}, result) do
    do_reverse(next, push(result, elem))
  end
end
