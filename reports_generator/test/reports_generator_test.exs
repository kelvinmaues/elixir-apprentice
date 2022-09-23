defmodule ReportsGeneratorTest do
  use ExUnit.Case

  @file_name_test "report_test.csv"
  @file_names_test ["report_test.csv", "report_test.csv"]

  describe "build/1" do
    test "builds the report" do
      # setup
      file_name = @file_name_test

      # exercise
      response = ReportsGenerator.build(file_name)

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pizza" => 2
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "2" => 45,
          "3" => 31,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      # assertion
      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is 'users', returns the user who spends the most" do
      file_name = @file_name_test

      response =
        file_name |> ReportsGenerator.build() |> ReportsGenerator.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "when the option is 'foods', returns the most ordered food" do
      file_name = @file_name_test

      response =
        file_name |> ReportsGenerator.build() |> ReportsGenerator.fetch_higher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "when an invalid option is provided, returns error" do
      file_name = @file_name_test

      response =
        file_name |> ReportsGenerator.build() |> ReportsGenerator.fetch_higher_cost("drinks")

      expected_response = {:error, "Invalid option!"}

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "when the file list is provided, builds the report" do
      # setup
      file_names = @file_names_test

      # exercise
      response = ReportsGenerator.build_from_many(file_names)

      expected_response =
        {:ok,
         %{
           "foods" => %{
             "açaí" => 2,
             "churrasco" => 4,
             "esfirra" => 6,
             "hambúrguer" => 4,
             "pizza" => 4
           },
           "users" => %{
             "1" => 96,
             "10" => 72,
             "2" => 90,
             "3" => 62,
             "4" => 84,
             "5" => 98,
             "6" => 36,
             "7" => 54,
             "8" => 50,
             "9" => 48
           }
         }}

      # assertion
      assert response == expected_response
    end

    test "when a file list is not provided, returns an error" do
      response = ReportsGenerator.build_from_many("banana")

      expected_response = {:error, "Please provide a list of strings"}

      assert response == expected_response

    end
  end
end
