defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "when the params are valid, saves the user" do
      user_params = Map.from_struct(build(:user))

      response = CreateOrUpdate.call(user_params)

      expected_response = {:ok, "User created or update successfully!"}

      assert response == expected_response
    end

    test "when the params are invalid, returns an error" do
      user_params = Map.from_struct(build(:user, age: 10))

      response = CreateOrUpdate.call(user_params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
