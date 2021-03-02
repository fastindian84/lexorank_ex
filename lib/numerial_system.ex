defmodule LexorankEx.NumerialSystem do
  @list [
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d",
    "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
    "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z"
  ]

  @mapping Enum.with_index(@list)
           |> Enum.into(%{}, fn({el, index}) -> { el, index} end)

  @reverse_mapping Enum.into(@mapping, %{}, fn({key, value}) -> {value, key} end)
  @min List.first(@list)
  @max List.last(@list)
  @radix Enum.count(@list)


  def to_digit(char) do
    Map.get(@mapping, char)
  end

  def to_char(digit) do
    Map.get(@reverse_mapping, digit)
  end

  def min, do: @min
  def min_index, do: to_digit(@min)
  def max, do: @max
  def radix, do: @radix
end
