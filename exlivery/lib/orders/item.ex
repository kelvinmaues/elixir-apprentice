defmodule Exlivery.Orders.Item do
  @categories [:pizza, :hamburguer, :carne, :prato_feito, :japonesa, :sobremesa]
  @keys [:title, :description, :category, :unit_price, :quantity]
  @enforce_keys @keys
  defstruct @keys

  def build(title, description, category, unit_price, quantity)
      when quantity > 0 and category in @categories do
    unit_price
    |> Decimal.cast()
    |> build_item(title, description, category, quantity)
  end

  def build(_title, _description, _category, _unit_price, _quantity), do: {:error, "Invalid parameter"}

  defp build_item({:ok, unit_price}, title, description, category, quantity) do
    {:ok,
     %__MODULE__{
       title: title,
       description: description,
       category: category,
       unit_price: unit_price,
       quantity: quantity
     }}
  end

  defp build_item(:error, _title, _description, _category, _quantity), do: {:error, "Invalid price"}
end
