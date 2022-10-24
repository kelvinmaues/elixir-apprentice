defmodule Exlivery.Orders.Agent do
  use Agent

  alias Exlivery.Orders.Order

  @module_name __MODULE__

  def start_link(initial_state \\ %{}) do
    Agent.start_link(
      fn -> initial_state end,
      name: @module_name
    )
  end

  def get(uuid) do
    Agent.get(
      @module_name,
      &get_order(&1, uuid)
    )
  end

  def list, do: Agent.get(@module_name, & &1)

  defp get_order(agent_state, uuid) do
    case agent_state[uuid] do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()

    Agent.update(
      @module_name,
      &update_order(
        &1,
        order,
        uuid
      )
    )

    {:ok, uuid}
  end

  defp update_order(agent_state, %Order{} = order, uuid) do
    Map.put(
      agent_state,
      uuid,
      order
    )
  end
end
