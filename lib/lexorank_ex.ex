defmodule LexorankEx do
  alias LexorankEx.Oparations.{Add, Partition, Substract, Coersion}

  # def min do
  #   "0|000000:"
  # end
  #
  # def next(rank) do
  #
  # end
  #
  # def prev(rank) do
  #
  # end

  def between(left, right) do
    [start_rank, end_rank] = Enum.sort([left, right])

    {start_digits, end_digits} = Coersion.coerce(start_rank, end_rank)

    { half, _reminder } = Partition.call(end_digits)

    division = Substract.call(end_digits, half)

    Add.call(start_digits, division)
    |> Coersion.translate_to_chars()
  end

  # def min(rank) do
  #   ranked_value(rank, :min)
  # end
  #
  # def max(rank) do
  #   ranked_value(rank, :max)
  # end
  #
  # defp ranked_value(rank, edge) when is_binary(rank) do
  #   length = String.length(rank)
  #   Range.new(0, length)
  #   |> Enum.map(fn(_) -> apply(NumerialSystem, edge, []) end)
  #   |> Enum.join()
  # end
  # defp ranked_value(_, _), do: raise "Not supported parameter. Expected string"
end
