defmodule LexorankEx do
  alias LexorankEx.Operations.{Add, Divide, Subtract}
  alias LexorankEx.Utils
  alias LexorankEx.NumeralSystem

  @default_rank_step 8

  @spec minimum_value(non_neg_integer()) :: String.t()
  def minimum_value(division \\ 1) do
    NumeralSystem.min(division)
  end

  @spec maximum_value(non_neg_integer()) :: String.t()
  def maximum_value(division \\ 1) do
    NumeralSystem.max(division)
  end

  @doc """
  Returns next lexically greater value for provided rank

  LexorankEx.next("a") => "i" default step is #{@default_rank_step}

  LexorankEx.next("a", step = 1) => "b"
  """
  @spec next(String.t(), non_neg_integer()) :: String.t()
  def next(rank, step \\ @default_rank_step) do
    numbers = Utils.to_numbers(rank)
    increment = Utils.normalize_step(step, numbers)
    result = Add.call(numbers, increment) |> Utils.to_string()

    if result > rank do
      result
    else
      raise LexorankEx.MaxValueReachedError
    end
  end

  @doc """
  Returns next lexically lesser value for provided rank

  LexorankEx.prev("i") => "a" default step is #{@default_rank_step}

  LexorankEx.prev("b", step = 1) => "a"
  """
  @spec prev(String.t(), non_neg_integer()) :: String.t()
  def prev(rank, step \\ @default_rank_step) do
    numbers = Utils.to_numbers(rank)
    decrement = Utils.normalize_step(step, numbers)
    Subtract.call(numbers, decrement) |> Utils.to_string()
  end

  @doc """
  The result is a middle rank for NumeralSystem with radix == 62
  """
  @spec middle(non_neg_integer()) :: String.t()
  def middle(division) when is_integer(division) do
    between(NumeralSystem.min(division), NumeralSystem.max(division))
  end

  @doc """
  Returns middle point between two strings.

  between("a", "c") => "b"

  between("a", "b") => "aV"
  """
  @spec between(String.t(), String.t()) :: String.t()
  def between(string, string), do: raise(LexorankEx.Error.exception("Strings are equal."))

  def between(left, right) do
    [min, max] = Enum.sort([left, right])
    min_numbers = Utils.to_numbers(min)
    max_numbers = Utils.to_numbers(max)
    {min_numbers, max_numbers} = Utils.equalize_length(min_numbers, max_numbers)

    Add.call(min_numbers, max_numbers)
    |> Divide.call()
    # Drop extra undesired item which may be introduced by Add.call/2, e.g.
    # Add.call([36], [38]) => [12, 1]
    # Divide.call([12, 1]) => [37, 0]
    # Enum.take([37, 0], 1) => [37]
    |> Enum.take(length(min_numbers))
    # If there is no space left between two ranks (eg. 'a' and 'b'),
    # division result is equal to smaller rank ('a').
    # In this case we need to add 1 symbol to make it lexicographically bigger ('aV').
    |> resolve_clash(min_numbers)
    |> Utils.to_string()
  end

  defp resolve_clash(min, min) do
    [div(NumeralSystem.radix(), 2) | min]
  end

  defp resolve_clash(between, _), do: between

  @doc """
  Returns the distance between two values
  """
  @spec distance(String.t(), String.t()) :: non_neg_integer()
  def distance(left, right) do
    [min, max] = Enum.sort([left, right])
    min_numbers = Utils.to_numbers(min)
    max_numbers = Utils.to_numbers(max)
    {min_numbers, max_numbers} = Utils.equalize_length(min_numbers, max_numbers)

    Subtract.call(max_numbers, min_numbers)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {number, index}, acc ->
      acc + number * NumeralSystem.radix() ** index
    end)
  end
end
