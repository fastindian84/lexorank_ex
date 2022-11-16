defmodule LexorankEx.UtilsTest do
  use ExUnit.Case
  alias LexorankEx.Utils

  test "#string/1 + #to_numbers/1" do
    expectations = [
      {[1], "1"},
      {[0, 1, 61], "z10"}
    ]

    for {numbers, string} <- expectations do
      assert numbers == Utils.to_numbers(string)
      assert string == Utils.to_string(numbers)
    end
  end

  test "#equalize_length/1" do
    expectations = [
      {{[], []}, {[], []}},
      {{[1], [1]}, {[1], [1]}},
      {{[1], [1, 1, 1]}, {[0, 0, 1], [1, 1, 1]}}
    ]

    for {{numbers1, numbers2}, result} <- expectations do
      assert result == Utils.equalize_length(numbers1, numbers2)
    end
  end

  test "#normalize_step/2" do
    expectations = [
      {{12, [1]}, [12]},
      {{12, [1, 1, 1]}, [12, 0, 0]}
    ]

    for {{step, numbers}, result} <- expectations do
      assert result == Utils.normalize_step(step, numbers)
    end
  end
end
