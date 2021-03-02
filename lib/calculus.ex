defmodule LexorankEx.Calculus do
  import LexorankEx.NumerialSystem, only: [to_digit: 1, to_char: 1, min_index: 0, radix: 0]

  @doc"""
  (1) determining when a carry happens—when the sum of two elements was ≥ Radix;
  (2) tracking the carry as it moved leftwards; and
  (3) handling arrays of different lengths.
  """
  def sum(rank1, rank2) do

  end

  @doc"""
  Consider two numbers, a and b. Their mean is (a + b) / 2.
  This mean comes from splitting the interval between a and b into two pieces.
  N evenly-spaced points between a and b (not including these) comes from splitting the interval into N + 1 pieces:
    a + (b - a) / (N + 1) * i, where i runs from 1 to N.

    a + (b - a) / (N + 1) * i
    = ((N + 1) * a + b * i - a * i) / (N + 1)
    = (a / (N + 1)) * (N + 1 - i) + (b / (N + 1)) * i

  We’d like the N ≥ 1 evenly-spaced numbers between a and b, for our case where 0 ≤ a, b < 1 and both are expressed as arrays of digits.
  A key element of this is dividing an array of digits by a scalar, which can be quite large (N + 1 potentially much larger than base-B).
  """
  def scalar(numbers, step \\ 8) do
    Enum.reduce(numbers, {[], 0}, fn(elem, {result, reminder}) ->
      number = elem + reminder * radix();
      point = Integer.floor_div(number, step)


      {result ++ [point], rem(number, step)};
    end)
  end

  def coercion(rank1, rank2) do
    diff = String.length(rank1) - String.length(rank2)

    cond do
      diff == 0 -> {signature(rank1), signature(rank2)}
      diff < 0 -> {signature(rank1, (diff * -1)), signature(rank2)}
      diff > 0 -> {signature(rank1), signature(rank2, diff)}
    end
  end

  def signature(rank, pading \\ 0) when is_binary(rank) do
    rank
    |> String.split(~r//)
    |> translate_to_digits([])
    |> add_padding(pading)
  end
  def translate_to_digits([], acc), do: acc
  def translate_to_digits([head | tail], acc) do
    case head do
      "" -> translate_to_digits(tail,  acc)
      _ ->
        translate_to_digits(tail, [to_digit(head) | acc])
    end
  end

  defp add_padding(sign, 0),  do: sign
  defp add_padding(sign, number) do
    padding = Range.new(1, number)
              |> Enum.map(fn(_) -> min_index() end)

    sign ++ padding
  end

  # def next(rank) do
  #   signature(rank)
  #   |> move(1)
  # end
  #
  # def move(rank, steps) do
  # end
end
