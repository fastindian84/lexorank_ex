defmodule LexorankEx.Bucket do
  @default_rank_step 8

  @next_backet %{
    1 => 2,
    2 => 3,
    3 => 1,
  }

  def new(value, start_point \\ :start) do
    {bucket, rank} = parse(value)

    new_bucket = @next_backet[bucket] || 1

    division = String.length(rank)

    start_rank = case start_point do
      :start -> LexorankEx.minimum_value(division)
      :middle -> LexorankEx.middle(division)
    end

    to_rank(new_bucket, start_rank)
  end

  def minimum_value(bucket \\ 1, division \\ 1)do
    to_rank(bucket, LexorankEx.minimum_value(division))
  end

  def maximum_value(bucket \\ 1, division \\ 1) do
    to_rank(bucket, LexorankEx.maximum_value(division))
  end

  def next(value, step \\ @default_rank_step) do
    {bucket, rank} = parse(value)

    next_rank = LexorankEx.next(rank, step)

    to_rank(bucket, next_rank)
  end

  def prev(value, step \\ @default_rank_step) do
    {bucket, rank} = parse(value)

    prev_rank = LexorankEx.prev(rank, step)

    to_rank(bucket, prev_rank)
  end

  def middle(division) when is_integer(division) do
    middle = LexorankEx.middle(division)

    to_rank(1, middle)
  end

  def between(left, right) do
    {l_bucket, l_rank} = parse(left)
    {r_bucket, r_rank} = parse(right)

    if (l_bucket != r_bucket) do
      raise LexorankEx.Bucket.MismatchError
    end

    between_rank = LexorankEx.between(l_rank, r_rank)

    to_rank(l_bucket, between_rank)
  end

  def distance(left, right) do
    {l_bucket, l_rank} = parse(left)
    {r_bucket, r_rank} = parse(right)

    if (l_bucket != r_bucket) do
      raise LexorankEx.Bucket.MismatchError
    end

    LexorankEx.distance(l_rank, r_rank)
  end

  defp to_rank(bucket, rank) do
    "#{bucket}|#{rank}"
  end

  defp parse("1|" <> rank), do: {1, rank}
  defp parse("2|" <> rank), do: {2, rank}
  defp parse("3|" <> rank), do: {3, rank}
  defp parse(rank) do
    {0, rank}
  end
end
