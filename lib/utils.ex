defmodule LexorankEx.Utils do
  alias LexorankEx.NumeralSystem

  @spec to_string([non_neg_integer()]) :: String.t()
  def to_string(numbers) do
    Enum.map(numbers, &NumeralSystem.to_char/1) |> Enum.reverse() |> Enum.join()
  end

  @spec to_numbers(String.t()) :: [non_neg_integer()]
  def to_numbers(str) do
    String.codepoints(str) |> Enum.map(&NumeralSystem.to_number/1) |> Enum.reverse()
  end

  @spec equalize_length([non_neg_integer()], [non_neg_integer()]) ::
          {[non_neg_integer()], [non_neg_integer()]}
  def equalize_length(numbers1, numbers2) do
    len1 = length(numbers1)
    len2 = length(numbers2)
    max_lex = Enum.max([len1, len2])
    {add_padding(numbers1, max_lex - len1), add_padding(numbers2, max_lex - len2)}
  end

  @spec normalize_step(non_neg_integer(), [non_neg_integer()]) :: [non_neg_integer()]
  def normalize_step(step, numbers) do
    [step | List.duplicate(0, length(numbers) - 1)]
  end

  defp add_padding(numbers, 0), do: numbers

  defp add_padding(numbers, padding_len) do
    List.duplicate(0, padding_len) ++ numbers
  end
end
