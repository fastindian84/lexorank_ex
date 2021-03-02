defmodule LexorankEx.CalculusTest do
  use ExUnit.Case
  import LexorankEx.Calculus

  test "#signature/2" do
    assert [40, 10, 1] = signature("1Ae")
    assert [40, 10, 1, 0, 0, 0, 0] = signature("1Ae", 4)
  end

  test "#coercion/2" do
    {sign1, sign2} = coercion("0000", "aaacvfa")

    assert Enum.count(sign1) == Enum.count(sign2)
  end

  test "scalar/2" do
    assert {[0, 21, 21], 2} = scalar([1,2,3], 3)
    assert {[0, 16, 0], 3} = scalar([1,2,3], 4)
    assert {[0, 37, 37], 2} = scalar([3,2,1], 5)
  end

end
