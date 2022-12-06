defmodule LexorankEx.Operations.Divide do
  @moduledoc """
  Divides rank in number representation by 2, flooring the result for least significant number.

  Example:
    LexorankEx.Operations.Divide.call([19, 2])
    [9, 1]
  """
  import LexorankEx.NumeralSystem, only: [radix: 0]

  @spec call([non_neg_integer()]) :: [non_neg_integer()]
  def call(numbers) do
    numbers
    |> Enum.reverse()
    |> Enum.reduce({[], 0}, fn el, {acc, rem} ->
      number = el + rem * radix()
      el = div(number, 2)
      {[el | acc], rem(number, 2)}
    end)
    |> elem(0)
  end
end
