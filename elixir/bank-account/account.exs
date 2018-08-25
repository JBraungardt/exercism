defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  use Agent

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    initial_balance = 0
    {:ok, pid} = Agent.start_link(fn -> initial_balance end)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if account_open?(account) do
      Agent.get(account, fn balance -> balance end)
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    if account_open?(account) do
      Agent.update(account, fn balance -> balance + amount end)
    else
      {:error, :account_closed}
    end
  end

  defp account_open?(account) do
    Process.alive?(account)
  end
end
