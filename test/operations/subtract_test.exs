defmodule LexorankEx.Operations.SubtractTest do
  use ExUnit.Case
  import LexorankEx.Operations.Subtract
  # All numbers are inverted 1000 is 0001
  test "#call" do
    assert [1] == call([2], [1])
    # > 10 - 1 = 9
    assert [61, 0] == call([0, 1], [1, 0])
    # > 9100 - 1 = 9099
    assert [61, 61, 0, 9] == call([0, 0, 1, 9], [1, 0, 0, 0])
    # > 1000 - 1 = 999
    assert [61, 61, 61, 0] == call([0, 0, 0, 1], [1, 0, 0, 0])
    # > 101 - 99 = 2
    assert [2, 0, 0] == call([1, 0, 1], [61, 61, 0])
  end
end
