defmodule LexorankEx.Oparations.Fraction do
  import LexorankEx.NumerialSystem, only: [radix: 0]

  def call(0), do: []
  def call(reminder) when reminder < 0, do: []
  def call(reminder) do
    places = ceil(:math.log(2) / :math.log(radix()))
    scale = :math.pow(radix(), places)
    scaled = round(reminder / 2 * scale)

    call(scaled, [])
  end
  def call(0, acc), do: Enum.reverse(acc)
  def call(number, acc) do
    left = Integer.floor_div(number, radix())
    digit = rem(number, radix())

    call(left, [digit | acc])
  end
end
