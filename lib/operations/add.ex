defmodule LexorankEx.Oparations.Add do
  import LexorankEx.NumerialSystem, only: [max_index: 0]

  def call(left, right) do
    call(left, right, [])
  end
  defp call([carry], [], acc) do
    Enum.reverse(acc) ++ [carry]
  end
  defp call([], [], acc) do
    Enum.reverse(acc)
  end
  defp call([digit | tail], [digit2 | tail2], acc) do
    sum = digit + digit2

    case sum <= max_index() do
      true -> call(tail, tail2, [sum | acc])
      false ->
        shifted = increment_list(tail)
        # The increment_list list is a operation itself
        # We need to decrease added value by 1
        # Radix 10       Radix 62
        #   99              61 61
        # +  1             +    1
        # ======        ==========
        #  100             1  0  0

        diff = digit + digit2 - max_index() - 1
        call(shifted, tail2, [diff | acc])
    end
  end

  defp increment_list(list) do
    increment_list(list, [])
  end
  defp increment_list([], acc) do
    # We've reached the the maximum value in current division
    # 61 61 61
    acc ++ [1]
  end
  defp increment_list([head | tail], acc) do
    result = head + 1

    case result <= max_index() do
      true -> Enum.reverse(acc) ++ [result] ++ tail
      false ->
        increment_list(tail, [0 | acc])
    end
  end
end
