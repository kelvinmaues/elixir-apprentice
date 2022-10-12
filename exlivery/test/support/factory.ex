defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

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

  def order_factory do
    %Order{
      delivery_address: "Rua das Grumixamas",
      items: [
        build(:item),
        build(
          :item,
          title: "X-burguer",
          category: :hamburguer,
          quantity: 2,
          unit_price: Decimal.new("15.90")
        )
      ],
      total_price: Decimal.new("122.80"),
      user_cpf: "123456789"
    }
  end
end
