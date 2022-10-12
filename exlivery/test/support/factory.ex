defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  def user_factory do
    %User{
      name: "Kelvin",
      email: "kelvin@email.com",
      age: 29,
      address: "Rua das Grumixamas",
      cpf: "123456789"
    }
  end

  def item_factory do
    %Item{
      title: "Pizza de Calabresa",
      description: "Deliciosa pizza de calabrase com passa romana.",
      category: :pizza,
      quantity: 2,
      unit_price: Decimal.new("45.50")
    }
  end
end
