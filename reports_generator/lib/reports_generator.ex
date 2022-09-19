# defmodule ReportsGenerator do alias ReportsGenerator.Parser
#   def build(filename) do
#     filename
#     |> Parser.parse_file()
#     |> Enum.reduce(%{}, fn line, acc_report -> sum_price_values(line, acc_report) end)
#   end

#   defp sum_price_values(line, acc_report) do
#     [id, _food_name, price] = line
#     Map.put(acc_report, id, (acc_report[id] || 0) + price)
#   end
# end

defmodule ReportsGenerator do
  def build(filename) do
    case File.read("reports/#{filename}") do
      {:ok, result} -> result
      {:error, reason} -> reason
      _ -> "Unknown error"
    end
  end

end
