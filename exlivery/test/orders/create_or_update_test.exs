defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.{Users}
  alias Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      cpf = "123456789"
      user = build(:user, cpf: cpf)

      Exlivery.start_agents()

      UserAgent.save(user)

      item1 = Map.from_struct(build(:item))
      item2 = Map.from_struct(build(:item, title: "Pizza de Banco", quantity: 1))

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when the params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with the given cpf, returns an error", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: "12232334", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert expected_response == response
    end

    test "when some item is invalid, returns an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid items."}

      assert expected_response == response
    end

    test "when there is not item, returns an error", %{user_cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
