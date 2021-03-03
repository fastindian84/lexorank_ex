defmodule LexorankEx.Oparations.Coersion do
  import LexorankEx.NumerialSystem, only: [to_digit: 1, to_char: 1, min_index: 0]
  alias LexorankEx.Oparations.{Add, Substract}

  @doc"""
  (1) determining when a carry happens—when the sum of two elements was ≥ Radix;
  (2) tracking the carry as it moved leftwards; and
  (3) handling arrays of different lengths.
  """
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
    |> translate_to_digits([])
    |> add_padding(pading)
  end

  def translate_to_digits([], acc), do: acc
  def translate_to_digits([head | tail], acc) do
    case head do
      "" -> translate_to_digits(tail,  acc)
      _ ->
        translate_to_digits(tail, [to_digit(head) | acc])
    end
  end

  def translate_to_chars(digits) do
    Enum.map(digits, &to_char/1)
    |> Enum.join()
  end

  defp add_padding(sign, 0),  do: sign
  defp add_padding(sign, number) do
    padding = Range.new(1, number)
              |> Enum.map(fn(_) -> min_index() end)

    sign ++ padding
  end
end
