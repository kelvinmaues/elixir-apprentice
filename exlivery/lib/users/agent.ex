defmodule Exlivery.Users.Agent do
  use Agent

  alias Exlivery.Users.User

  @module_name __MODULE__

  def start_link(initial_state \\ %{}) do
    Agent.start_link(
      fn -> initial_state end,
      name: @module_name
    )
  end

  def get(cpf) do
    Agent.get(
      @module_name,
      &get_user(&1, cpf)
    )
  end

  defp get_user(agent_state, cpf) do
    case agent_state[cpf] do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def save(%User{} = user) do
    Agent.update(
      @module_name,
      &update_user(&1, user)
    )
  end

  defp update_user(agent_state, %User{cpf: cpf} = user) do
    Map.put(
      agent_state,
      cpf,
      user
    )
  end
end
