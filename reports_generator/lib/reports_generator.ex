defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @report %{"foods" => %{}, "users" => %{}}
  @options ["foods", "users"]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(@report, fn line, acc_report -> generate_reports(line, acc_report) end)
  end

  def fetch_higher_cost(report, option) when option in @options do
    max_value = Enum.max_by(report[option], fn {_key, price} -> price end)
    {:ok, max_value}
  end

  def fetch_higher_cost(_report, _option), do: {:error, "Invalid option!"}

  defp generate_reports([id, food_name, price], %{"foods" => foods, "users" => users} = report) do
    users = Map.put(users, id, (users[id] || 0) + price)
    foods = Map.put(foods, food_name, (foods[food_name] || 0) + 1)

    %{report | "users" => users, "foods" => foods}
  end
end
