defmodule LexorankEx do
  alias LexorankEx.Oparations.{Add, Partition, Coersion, Fraction, Compare}

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
    [min, max] = Enum.sort([left, right])

    {min_digits, max_digits} = Coersion.coerce(min, max)

    {min_half, min_reminder} = Partition.call(min_digits)
    {max_half, max_reminder} = Partition.call(max_digits)

    reminder = min_reminder + max_reminder

    sum = Add.call(min_half, max_half)

    case Compare.between?(min_digits, sum, max_digits) do
      true -> Coersion.to_chars(sum)
      false ->
        (Fraction.call(reminder) ++ sum)
        |> Coersion.to_chars()
    end
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
