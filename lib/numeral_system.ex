defmodule LexorankEx.NumeralSystem do
  @list [?0..?9, ?A..?Z, ?a..?z]
        |> Enum.flat_map(&Enum.to_list/1)
        |> List.to_string()
        |> String.codepoints()

  @mapping Enum.with_index(@list) |> Enum.into(%{}, fn {el, index} -> {el, index} end)
  @reverse_mapping Enum.into(@mapping, %{}, fn {key, value} -> {value, key} end)
  @min List.first(@list)
  @max List.last(@list)
  @radix Enum.count(@list)
  @middle_index div(@radix, 2)

  def to_number(char) do
    Map.get(@mapping, char)
  end

  def to_char(number) do
    Map.get(@reverse_mapping, number)
  end

  def min, do: @min

  def min(division), do: to_rank(@min, division)

  def max, do: @max

  def max(division), do: to_rank(@max, division)

  def radix, do: @radix

  def middle_index, do: @middle_index

  defp to_rank(value, division) do
    List.duplicate(value, division) |> Enum.join()
  end
end
