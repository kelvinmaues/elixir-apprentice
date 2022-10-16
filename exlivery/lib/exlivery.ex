defmodule Exlivery do
  alias Exlivery.Orders
  alias Exlivery.Users
  alias Orders.Agent, as: OrderAgent
  alias Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Users.Agent, as: UserAgent
  alias Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link()
    OrderAgent.start_link()
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrder, as: :call
end
