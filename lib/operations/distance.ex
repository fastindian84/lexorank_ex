defmodule LexorankEx.Oparations.Distance do
  alias LexorankEx.Oparations.Substract
  import LexorankEx.NumerialSystem, only: [radix: 0]

  def call(max, min) do
    Substract.call(max, min)
    |> Enum.with_index()
    |> reduce(0)
  end

  defp reduce([], acc), do: acc
  defp reduce([{digit, index} | tail], acc) do
    case index do
      0 -> reduce(tail, acc + digit)
      _ -> reduce(tail, acc + (digit * radix() ** index))
    end
  end
end
