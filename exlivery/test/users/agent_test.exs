defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link()

      response = UserAgent.save(user)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "get/1" do
    test "when the user is found, returns the user" do
      user = build(:user)
      UserAgent.start_link()
      UserAgent.save(user)

      response = UserAgent.get(user.cpf)

      expected_response =
        {:ok,
         %User{
           address: "Rua das Grumixamas",
           age: 29,
           cpf: "123456789",
           email: "kelvin@email.com",
           name: "Kelvin"
         }}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      UserAgent.start_link()

      response = UserAgent.get("098765432")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
