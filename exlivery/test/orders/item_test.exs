defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Orders.Item

  describe "build/4" do
    test "when the params are valid, returns item" do
      response =
        Item.build(
          "Pizza de Calabresa",
          "Deliciosa pizza de calabrase com passa romana.",
          :pizza,
          "45.50",
          2
        )

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when category is invalid, returns an error" do
      response =
        Item.build(
          "Pizza de Calabresa",
          "Deliciosa pizza de calabrase com passa romana.",
          :drink,
          "45.50",
          2
        )

      expected_response = {:error, "Invalid parameter"}

      assert response == expected_response
    end

    test "when quantity is less than 0, returns an error" do
      response =
        Item.build(
          "Pizza de Calabresa",
          "Deliciosa pizza de calabrase com passa romana.",
          :pizza,
          "45.50",
          0
        )

      expected_response = {:error, "Invalid parameter"}

      assert response == expected_response
    end

    test "when the price is invalid, returns an error" do
      response =
        Item.build(
          "Pizza de Calabresa",
          "Deliciosa pizza de calabrase com passa romana.",
          :pizza,
          "price",
          2
        )

      expected_response = {:error, "Invalid price"}

      assert response == expected_response
    end
  end
end
