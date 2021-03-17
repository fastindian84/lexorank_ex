defmodule LexorankEx.Oparations.PartitionTest do
  use ExUnit.Case
  import LexorankEx.Oparations.Partition

  test "#call" do
   assert {[31, 0], 0} == call([0, 1], 2)
   assert {[30, 0], 0} == call([60, 0], 2)
   assert {[0, 31, 0], 0} == call([0, 0, 1], 2)
   assert {[61, 0], 1} == call([61, 1], 2)
  end
end
