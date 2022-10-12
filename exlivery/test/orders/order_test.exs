defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Orders.Order

  describe "build/2" do
    test "when the params are valid, returns an order" do
      user = build(:user)

      items = [
        build(:item),
        build(
          :item,
          title: "X-burguer",
          category: :hamburguer,
          quantity: 2,
          unit_price: Decimal.new("15.90")
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "when there is no items in the order, returns an error" do
      user = build(:user)

      items = []

      response = Order.build(user, items)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
