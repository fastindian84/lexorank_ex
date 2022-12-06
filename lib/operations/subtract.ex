defmodule LexorankEx.Operations.Subtract do
  @moduledoc """
  Subtracts 2 ranks in number representation.
  Ranks are expected to have equal length.
  If second rank is greater, raises exception.

  Example:
    LexorankEx.Operations.Subtract.call([18, 2], [40, 1])
    [40, 0]
  """
  import LexorankEx.NumeralSystem, only: [radix: 0]

  @spec call([non_neg_integer()], [non_neg_integer()]) :: [non_neg_integer()]
  def call(left, right) do
    call(left, right, {[], 0})
  end

  defp call([], [], {acc, 0}) do
    Enum.reverse(acc)
  end

  defp call([], [], _) do
    raise LexorankEx.MinValueReachedError.exception("Nothing left to subtract")
  end

  defp call([h | tail1], [decr | tail2], {acc, leftover}) do
    decr = decr + leftover
    rem = rem(decr, radix())
    {h, decr} = if h < rem, do: {h + radix(), decr + radix()}, else: {h, decr}
    leftover = div(decr, radix())
    h = h - rem
    call(tail1, tail2, {[h | acc], leftover})
  end
end
