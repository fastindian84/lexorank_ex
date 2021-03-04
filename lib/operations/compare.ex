defmodule LexorankEx.Oparations.Compare do
  import LexorankEx.Oparations.Coersion, only: [to_chars: 1]

  def between?(left, middle, right) do
    left = to_chars(left)
    middle = to_chars(middle)
    right = to_chars(right)

    left < middle && middle < right
  end
end
