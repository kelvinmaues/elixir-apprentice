defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link()

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      expected_response =
        "123456789,Pizza de Calabresa,pizza,2,45.50X-burguer,hamburguer,2,15.90,122.80\n" <>
          "123456789,Pizza de Calabresa,pizza,2,45.50X-burguer,hamburguer,2,15.90,122.80\n"

      assert response == expected_response
    end
  end
end
