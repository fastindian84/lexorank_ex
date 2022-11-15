defmodule Bucket.BucketTest do
  use ExUnit.Case
  alias LexorankEx.Bucket

  test "#middle/1" do
    assert Bucket.middle(8) == "1|Uzzzzzzz"
  end

  test "new/1" do
    assert Bucket.new("00000") == "1|00000"
    assert Bucket.new("1|00000") == "2|00000"
    assert Bucket.new("2|00000") == "3|00000"
    assert Bucket.new("3|00000") == "1|00000"
    assert Bucket.new("3|00000", :start) == "1|00000"
    assert Bucket.new("3|00000", :middle) == "1|Uzzzz"
  end

  test "#next/1" do
    assert_raise LexorankEx.MaxValueReachedError, fn() ->
      Bucket.next("z")
    end

    assert Bucket.next("a", 1) == "0|b"
    assert Bucket.next("1|a") == "1|i"
    assert Bucket.next("1|00000") == "1|00008"
    assert Bucket.next("1|0000z") == "1|00017"
    assert Bucket.next("2|aaaaa") == "2|aaaai"
    assert Bucket.next("3|azzzz") == "3|b0007"
  end

  test "#prev/1" do
    assert_raise LexorankEx.MinValueReachedError, fn() ->
      Bucket.prev("1|00000")
    end

    assert Bucket.prev("b", 1) == "0|a"
    assert Bucket.prev("i") == "0|a"
    assert Bucket.prev("1|00008") == "1|00000"
    assert Bucket.prev("2|00017") == "2|0000z"
    assert Bucket.prev("3|aaaai") == "3|aaaaa"
    assert Bucket.prev("3|b0007") == "3|azzzz"
  end

  test "#between" do
    middle = Bucket.middle(8)
    next = Bucket.next(middle)

    Enum.reduce(0..100, [middle, next], fn(_, [min, max]) ->
      result = Bucket.between(min, max)

      assert [min, result, max] == Enum.sort([min, result, max])
      refute min == result

      [min, result]
    end)

    assert Bucket.between("1|a", "1|b") == "1|aV"
    assert Bucket.between("1|0", "1|01") == "1|00V"
    assert Bucket.between("1|a", "1|aF") == "1|a7"
    assert Bucket.between("1|a", "1|c") == "1|b"
    assert Bucket.between("1|0", "1|z") == "1|U"
    assert Bucket.between("2|AA", "2|AB") == "2|AAV"
    assert Bucket.between("2|aaaaz", "2|zzzzz") == "2|nIIIT"

    assert_raise LexorankEx.Bucket.MismatchError, fn() ->
      Bucket.between("1|aaaaz", "2|zzzzz")
    end
  end

  test "#distance/2" do
    assert Bucket.distance("1|V0000007", "1|V000000F") == 8
    assert Bucket.distance("2|00", "2|zz") == 3843
    assert Bucket.distance("2|000", "2|zzz") == 238327
    assert Bucket.distance("3|aa", "3|bb") == 63
    assert Bucket.distance("1|00", "1|010") == 62
    assert Bucket.distance("1|a0", "1|b") == 62
    assert Bucket.distance("2|a0", "2|b1") == 63
    assert Bucket.distance("3|a", "3|b") == 1

    assert_raise LexorankEx.Bucket.MismatchError, fn() ->
      Bucket.distance("1|aaaaz", "2|zzzzz")
    end
  end
end
