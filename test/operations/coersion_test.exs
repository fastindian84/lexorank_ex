defmodule LexorankEx.CoersionTest do
  use ExUnit.Case
  import LexorankEx.Oparations.Coersion

  test "#signature/2" do
    assert [40, 10, 1] = signature("1Ae")
    assert [0, 0, 0, 0, 40, 10, 1] = signature("1Ae", 4)
  end

  test "#coercion/2" do
    {sign1, sign2} = coerce("0000", "aaacvfa")

    assert Enum.count(sign1) == Enum.count(sign2)
  end
end
