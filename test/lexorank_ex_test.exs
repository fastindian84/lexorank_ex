defmodule LexorankExTest do

  use ExUnit.Case
  doctest LexorankEx

  test "#middle/1" do
    assert LexorankEx.middle(8) == "Uzzzzzzz"
  end

  test "#next/1" do
    assert_raise LexorankEx.MaxValueReachedError, fn() ->
      LexorankEx.next("z")
    end

    assert LexorankEx.next("a", 1) == "b"
    assert LexorankEx.next("a") == "i"
    assert LexorankEx.next("00000") == "00008"
    assert LexorankEx.next("0000z") == "00017"
    assert LexorankEx.next("aaaaa") == "aaaai"
    assert LexorankEx.next("azzzz") == "b0007"
  end

  test "#prev/1" do
    assert_raise LexorankEx.MinValueReachedError, fn() ->
      LexorankEx.prev("00000")
    end

    assert LexorankEx.prev("b", 1) == "a"
    assert LexorankEx.prev("i") == "a"
    assert LexorankEx.prev("00008") == "00000"
    assert LexorankEx.prev("00017") == "0000z"
    assert LexorankEx.prev("aaaai") == "aaaaa"
    assert LexorankEx.prev("b0007") == "azzzz"
  end
  test "#between" do
    middle = LexorankEx.middle(8)
    next = LexorankEx.next(middle)

    Enum.reduce(0..100, [middle, next], fn(_, [min, max]) ->
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
    assert LexorankEx.between("aaaaz", "zzzzz") == "nIIIT"
  end

  test "#distance/2" do
    assert LexorankEx.distance("V0000007", "V000000F") == 8
    assert LexorankEx.distance("00", "zz") == 3843
    assert LexorankEx.distance("000", "zzz") == 238327
    assert LexorankEx.distance("aa", "bb") == 63
    assert LexorankEx.distance("00", "010") == 62
    assert LexorankEx.distance("a0", "b") == 62
    assert LexorankEx.distance("a0", "b1") == 63
    assert LexorankEx.distance("a", "b") == 1
  end
end
