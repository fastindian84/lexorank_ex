defmodule LexorankEx.Oparations.Coersion do
  import LexorankEx.NumerialSystem, only: [to_digit: 1, to_char: 1, min_index: 0]

  def coerce(rank1, rank2) do
    diff = String.length(rank1) - String.length(rank2)

    cond do
      diff == 0 -> {signature(rank1), signature(rank2)}
      diff < 0 -> {signature(rank1, (diff * -1)), signature(rank2)}
      diff > 0 -> {signature(rank1), signature(rank2, diff)}
    end
  end

  def signature(rank, pading \\ 0) when is_binary(rank) do
    rank
    |> String.split(~r//)
    |> to_digits([])
    |> add_padding(pading)
  end

  def to_digits([], acc), do: acc
  def to_digits([head | tail], acc) do
    case head do
      "" -> to_digits(tail,  acc)
      _ ->
        to_digits(tail, [to_digit(head) | acc])
    end
  end

  def to_chars(digits) do
    to_chars(digits, [])
  end
  def to_chars([], acc), do: Enum.join(acc)
  def to_chars([head | tail], acc) do
    to_chars(tail, [to_char(head) | acc])
  end

  defp add_padding(sign, 0),  do: sign
  defp add_padding(sign, number) do
    padding = Range.new(1, number)
              |> Enum.map(fn(_) -> min_index() end)

    padding ++ sign
  end
end
