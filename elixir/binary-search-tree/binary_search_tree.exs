defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: node_value, left: nil} = node, data) when data <= node_value do
    %{node | left: new(data)}
  end

  def insert(%{data: node_value} = node, data) when data <= node_value do
    %{node | left: insert(node.left, data)}
  end

  def insert(%{data: node_value, right: nil} = node, data) when data > node_value do
    %{node | right: new(data)}
  end

  def insert(%{data: node_value} = node, data) when data > node_value do
    %{node | right: insert(node.right, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    in_order(tree, [])
    |> Enum.reverse()
  end

  defp in_order(%{data: value, left: nil, right: nil}, list) do
    [value | list]
  end

  defp in_order(%{data: value} = node, list) do
    list = traverse_left(node, list)
    list = [value | list]
    traverse_right(node, list)
  end

  defp traverse_left(%{left: nil}, list) do
    list
  end

  defp traverse_left(%{left: node}, list) do
    in_order(node, list)
  end

  defp traverse_right(%{right: nil}, list) do
    list
  end

  defp traverse_right(%{right: node}, list) do
    in_order(node, list)
  end
end
