defmodule LexorankEx.Oparations.Substract do
  import LexorankEx.NumerialSystem, only: [max_index: 0]
  @doc"""
  All values are inverted:
  1000 => 0001

  Becouse base is 62 not 100
    00001
   -10000
  --------
  [61, 61, 61, 0
  """

  def call(left, right) do
    call(left, right, [])
  end
  defp call([], [], acc),  do: Enum.reverse(acc)
  defp call([left_head | left_tail], [right_head | right_tail], acc) do
    case left_head >= right_head do
      true ->
        result = left_head - right_head
        call(left_tail, right_tail, [result | acc])
      false ->
        # look for a digit to the left to borrow from
        shifted = decrement_list(left_tail)
        current = left_head + max_index()
        # Why do we need to substract 1 from sig2_head?
        # cos decrement_list is considered as -1 operation itself
        # radix - is a maximum value in a column, in a Numerial system maximum value in column is a 9 (0..9)
        # Example:
        #           Radix = 10        Radix = 62
        #                10    9 == 61   10
        #               - 1             - 1
        #               -----           ----
        #                 9              61

        call([current | shifted], [right_head - 1 | right_tail], acc)
    end
  end

  defp decrement_list(rest) do
    decrement_list(rest, [])
  end
  defp decrement_list([], _) do
    raise LexorankEx.MinValueReachedError.exception("Nothing left to substract")
  end
  defp decrement_list([head | tail], acc) do
    case head > 0 do
      true ->
         Enum.reverse(acc) ++ [head - 1] ++ tail
      false ->
        decrement_list(tail, [max_index() | acc])
    end
  end
end
