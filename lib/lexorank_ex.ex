defmodule LexorankEx do
  alias LexorankEx.Oparations.{Add, Partition, Coersion, Fraction, Compare}
  alias LexorankEx.NumerialSystem

  @default_rank_step 8

  def minimum_value do
    NumerialSystem.min
  end

  def maximum_value do
    NumerialSystem.max
  end

  def next(rank, step \\ @default_rank_step) do
    import LexorankEx.NumerialSystem, only: [min: 1]

    {digits, [_| zeros]} = Coersion.coerce(rank, min(String.length(rank)))

    resut = Add.call(digits, [step | zeros])
            |> Coersion.to_chars()

    case Enum.sort([resut, rank]) do
      [^rank, ^resut] -> resut
      _ -> raise LexorankEx.Error.exception("""
          There is no space to grow. Generated value is lexically smaller than provied rank
        """)
    end
  end

  # def rank_step(length) do
  #   min(length - 1) ++
  # end

  def prev(rank, step \\ @default_rank_step) do

  end

  @doc"""
  The result is a middle rank for NumerialSystem with radix == 62
  """
  def middle(division) when is_integer(division) do
    import LexorankEx.NumerialSystem, only: [min: 1, max: 1]

    between(min(division), max(division))
  end
  def middle(_), do: raise LexorankEx.Error.exception("Please, provide division number")

  @doc"""
  Returns middle point between two string.
  between("a", "c") => "b"
  between("a", "b") => "aV"
  """
  def between(string, string), do: raise LexorankEx.Error.exception("Strings are equal.")
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
