defmodule LexorankEx.Oparations.Partition do
  import LexorankEx.NumerialSystem, only: [radix: 0]

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
  def call(numbers, denominator \\ 2) do
    call(Enum.reverse(numbers), denominator, {[], 0})
  end
  defp call([], _denominator, {acc, reminder}) do
    {acc, reminder}
  end
  defp call([head | tail], denominator, {acc, reminder}) do
      number = head + reminder * radix()

      ceil = Integer.floor_div(number, denominator)

      call(tail, denominator, {[ceil | acc], rem(number, denominator)})
  end
end
