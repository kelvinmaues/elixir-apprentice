defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @report %{"foods" => %{}, "users" => %{}}
  @options ["foods", "users"]

  def fetch_higher_cost(report, option) when option in @options do
    max_value = Enum.max_by(report[option], fn {_key, price} -> price end)
    {:ok, max_value}
  end

  def fetch_higher_cost(_report, _option), do: {:error, "Invalid option!"}

  defp generate_reports([id, food_name, price], %{"foods" => foods, "users" => users}) do
    users = Map.put(users, id, (users[id] || 0) + price)
    foods = Map.put(foods, food_name, (foods[food_name] || 0) + 1)

    Parser.parse_report(foods, users)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end

  defp sum_reports(%{"foods" => initial_foods, "users" => initial_users}, %{
         "foods" => current_foods,
         "users" => current_users
       }) do
    foods = merge_maps(initial_foods, current_foods)
    users = merge_maps(initial_users, current_users)

    Parser.parse_report(foods, users)
  end

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(@report, fn line, acc_report -> generate_reports(line, acc_report) end)
  end

  def build_from_many(file_names) when not is_list(file_names) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(file_names) do
    result =
      file_names
      |> Task.async_stream(&build/1)
      |> Enum.reduce(@report, fn {:ok, result}, acc_report -> sum_reports(acc_report, result) end)
    {:ok, result}
  end
end
