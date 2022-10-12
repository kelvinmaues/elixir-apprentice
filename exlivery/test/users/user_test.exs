defmodule Exlivery.Users.UserTest do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Users.User

  describe "build/5" do
    test "when the params are valid, return the user" do
      response = User.build("Kelvin", "kelvin@email.com", "123456789", 29, "Rua das Grumixamas")

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when the age is invalid, return an error" do
      response = User.build("Kelvin", "kelvin@email.com", "123456789", 17, "Rua das Grumixamas")

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when the cpf is invalid, return an error" do
      response = User.build("Kelvin", "kelvin@email.com", 123_456_789, 20, "Rua das Grumixamas")

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
