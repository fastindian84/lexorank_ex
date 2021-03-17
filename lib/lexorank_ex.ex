defmodule LexorankEx do
  alias LexorankEx.Oparations.{Add, Partition, Coersion, Fraction, Compare, Substract}
  alias LexorankEx.NumerialSystem

  @default_rank_step 8

  def minimum_value do
    NumerialSystem.min
  end

  def maximum_value do
    NumerialSystem.max
  end

  @doc"""
  Returns next lexically greater value for provider rank

  LexorankEx.next("a") => "i" default step is #{@default_rank_step}

  LexorankEx.next("a", step = 1) => "b"
  """
  def next(rank, step \\ @default_rank_step) do
    import LexorankEx.NumerialSystem, only: [min: 1]

    {digits, [_| zeros]} = Coersion.coerce(rank, min(String.length(rank)))

    result = Add.call(digits, [step | zeros])
            |> Coersion.to_chars()

    case Enum.sort([result, rank]) do
      [^rank, ^result] -> result
      _ -> raise LexorankEx.MaxValueReachedError
    end
  end

  @doc"""
  Returns next lexically lesser value for provider rank

  LexorankEx.prev("i") => "a" default step is #{@default_rank_step}

  LexorankEx.prev("b", step = 1) => "a"
  """
  def prev(rank, step \\ @default_rank_step) do
    import LexorankEx.NumerialSystem, only: [min: 1]

    {digits, [_| zeros]} = Coersion.coerce(rank, min(String.length(rank)))

    Substract.call(digits, [step | zeros])
    |> Coersion.to_chars()
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
  Returns middle point between two strings.

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
end
