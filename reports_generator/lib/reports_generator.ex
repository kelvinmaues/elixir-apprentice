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
    "reports/#{filename}"
    |> File.stream!() # Read file line by line executing a function for each line
    |> Enum.map(fn line -> parse_line(line) end) # &parse_line(&1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
