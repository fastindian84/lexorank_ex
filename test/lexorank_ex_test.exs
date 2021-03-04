defmodule LexorankExTest do
  use ExUnit.Case
  doctest LexorankEx

  test "#middle/1" do
    assert LexorankEx.middle(8) == "UzUzUzUz"
  end

  test "#next/1" do
    # assert LexorankEx.next("a") == 'i'
    assert_raise LexorankEx.Error, fn() ->
      LexorankEx.next("z")
    end

    assert LexorankEx.next("00000") == "00008"
    assert LexorankEx.next("0000z") == "00017"
    assert LexorankEx.next("aaaaa") == "aaaai"
    assert LexorankEx.next("azzzz") == "b0007"
  end


  test "#between" do
    Enum.reduce(0..100, ["000000", "zzzzzz"], fn(_, [min, max]) ->
      result = LexorankEx.between(min, max)

      assert [min, result, max] == Enum.sort([min, result, max])
      refute min == result

      [min, result]
    end)

    assert LexorankEx.between("a", "b") == "aV"
    assert LexorankEx.between("0", "01") == "00V"
    assert LexorankEx.between("a", "aF") == "a7"
    assert LexorankEx.between("a", "c") == "b"
    assert LexorankEx.between("0", "z") == "U"
    assert LexorankEx.between("AA", "AB") == "AAV"
    assert LexorankEx.between("aaaaz", "zzzzz") == "nHnHy"
  end
end
