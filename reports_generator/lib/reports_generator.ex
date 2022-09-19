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
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, file_content}), do: file_content
  defp handle_file({:error, _reason}), do: "Error reading file!"
end
