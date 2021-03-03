defmodule LexorankExTest do
  use ExUnit.Case
  doctest LexorankEx

  test "#min" do
    assert LexorankEx.min() == '0|000000:'
  end

  test "#between" do
    assert LexorankEx.between("a", "b") == "an"
    # assert LexorankEx.between("AA", "AB") == "AAO"
  end
end
