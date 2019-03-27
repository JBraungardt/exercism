defmodule BinTree do
  import Inspect.Algebra

  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat([
      "(",
      to_doc(v, opts),
      ":",
      if(l, do: to_doc(l, opts), else: ""),
      ":",
      if(r, do: to_doc(r, opts), else: ""),
      ")"
    ])
  end
end

defmodule Zipper do
  defstruct tree: nil, node: nil, trail: []

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(bt) do
    %Zipper{tree: bt, node: bt}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree(z) do
    z.tree
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value(z) do
    z.node.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  def left(%Zipper{node: node, trail: trail} = z) do
    new_node = node.left

    case new_node do
      nil -> nil
      _ -> %Zipper{z | node: new_node, trail: [{:left, node} | trail]}
    end
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right(%Zipper{node: node, trail: trail} = z) do
    new_node = node.right

    case new_node do
      nil -> nil
      _ -> %Zipper{z | node: new_node, trail: [{:right, node} | trail]}
    end
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t() | nil
  def up(%Zipper{trail: []}), do: nil

  def up(%Zipper{trail: trail} = z) do
    [{_direction, node} | t] = trail
    %Zipper{z | node: node, trail: t}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value(z, v) do
    new_node = %BinTree{z.node | value: v}

    new_tree = update_tree(z, new_node)

    %Zipper{z | tree: new_tree, node: new_node}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(z, l) do
    new_node = %BinTree{z.node | left: l}

    new_tree = update_tree(z, new_node)

    %Zipper{z | tree: new_tree, node: new_node}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(z, r) do
    new_node = %BinTree{z.node | right: r}

    new_tree = update_tree(z, new_node)

    %Zipper{z | tree: new_tree, node: new_node}
  end

  defp update_tree(%Zipper{trail: []}, n), do: n
  defp update_tree(%Zipper{trail: trail} = z, n) do
    [{direction, node} | _t] = trail

    new_node =
      case direction do
        :left -> %BinTree{node | left: n}
        :right -> %BinTree{node | right: n}
      end

    update_tree(z |> up(), new_node)
  end
end
