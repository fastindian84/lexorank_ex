defmodule LexorankEx.Operations.Add do
  @moduledoc """
  Adds 2 ranks in number representation.
  Ranks are expected to have equal length.

  Example:
    LexorankEx.Operations.Add.call([40, 1], [40, 0])
    [18, 2]
  """
  import LexorankEx.NumeralSystem, only: [radix: 0]

  @spec call([non_neg_integer()], [non_neg_integer()]) :: [non_neg_integer()]
  def call(left, right) do
    call(left, right, {[], 0})
  end

  defp call([], [], {acc, 0}) do
    Enum.reverse(acc)
  end

  defp call([], [], {acc, leftover}) do
    h = rem(leftover, radix())
    leftover = div(leftover, radix())
    call([], [], {[h | acc], leftover})
  end

  defp call([h | tail1], [incr | tail2], {acc, leftover}) do
    sum = h + incr + leftover
    h = rem(sum, radix())
    leftover = div(sum, radix())
    call(tail1, tail2, {[h | acc], leftover})
  end
end
