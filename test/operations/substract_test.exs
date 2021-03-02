defmodule LexorankEx.Oparations.SubstractTest do
  use ExUnit.Case
  import LexorankEx.Oparations.Substract
  # All numbers are inverted 1000 is 0001
  test "#call" do
    assert [1] == call([2], [1])
    assert [62, 0] == call([0, 1], [1, 0])                      #> 10 - 1 = 9
    assert [62, 62, 0, 9] == call([0, 0, 1, 9], [1, 0, 0, 0])   #> 9100 - 1 = 9099
    assert [62, 62, 62, 0] == call([0, 0, 0, 1], [1, 0, 0, 0])  #> 1000 - 1 = 999
    assert [2, 0, 0] == call([1, 0, 1], [62, 62, 0])            #> 101 - 99 = 2
  end
end
