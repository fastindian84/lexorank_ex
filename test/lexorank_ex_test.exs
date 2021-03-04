defmodule LexorankExTest do
  use ExUnit.Case
  doctest LexorankEx

  test "#min" do
    assert LexorankEx.min() == '0|000000:'
  end

  test "#between" do
    Enum.reduce(0..100, ["000000", "zzzzzz"], fn(_, [min, max]) ->
      result = LexorankEx.between(min, max)

      assert [min, result, max] == Enum.sort([min, result, max])
      refute min == result

      [min, result]
    end)

    assert LexorankEx.between("0", "01") == "00V"
    assert LexorankEx.between("a", "aF") == "a7"
    assert LexorankEx.between("a", "c") == "b"
    assert LexorankEx.between("0", "z") == "U"
    assert LexorankEx.between("AA", "AB") == "AAV"
    assert LexorankEx.between("aaaaz", "zzzzz") == "nHnHy"
  end
end
