defmodule LexorankEx do
  alias LexorankEx.NumerialSystem

  def min do
    "0|000000:"
  end

  def next(rank) do

  end

  def prev(rank) do

  end

  # def between(rank, rank) do
  # TODO bascet separation
  # end
  def between(left, right) do

  end

  def min(rank) do
    ranked_value(rank, :min)
  end

  def max(rank) do
    ranked_value(rank, :max)
  end

  defp ranked_value(rank, edge) when is_binary(rank) do
    length = String.length(rank)
    Range.new(0, length)
    |> Enum.map(fn(_) -> apply(NumerialSystem, edge, []) end)
    |> Enum.join()
  end
  defp ranked_value(_, _), do: raise "Not supported parameter. Expected string"
end
