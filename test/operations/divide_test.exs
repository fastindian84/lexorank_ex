defmodule LexorankEx.Operations.DivideTest do
  use ExUnit.Case
  import LexorankEx.Operations.Divide

  test "#call" do
    assert [31, 0] == call([0, 1])
    assert [30, 0] == call([60, 0])
    assert [0, 31, 0] == call([0, 0, 1])
    assert [61, 0] == call([61, 1])
  end
end
