defmodule LexorankEx.Oparations.Add do
  import LexorankEx.NumerialSystem, only: [radix: 0]

  def call(signature1, signature2) do
    call(signature1, signature2, [])
  #     if (a.length !== b.length) { throw new Error('same length arrays needed'); }
  # let carry = rem >= den, res = b.slice();
  # if (carry) { rem -= den; }
  # a.reduceRight((_, ai, i) => {
  #   const result = ai + b[i] + carry;
  #   carry = result >= base;
  #   res[i] = carry ? result - base : result;
  # }, null);
  # return {res, carry, rem, den};

  end
  def call([carry], [], acc) do
    Enum.reverse(acc) ++ [carry]
  end
  def call([], [], acc) do
    Enum.reverse(acc)
  end
  def call([sig | tail], [sig2 | tail2], acc) do
    sum = sig + sig2

    case sum <= radix() do
      true -> call(tail, tail2, [sum | acc])
      false ->
        shifted = increment_list(tail)
        # The increment_list list is a operation itself
        # We need to decrease added value by 1
        # Radix 10       Radix 62
        #   99              62 62
        # +  1             +    1
        # ======        ==========
        #  100             1  0  0

        diff = sig + sig2 - radix() - 1
        call(shifted, tail2, [diff | acc])
    end
  end

  defp increment_list(list) do
    increment_list(list, [])
  end
  defp increment_list([], acc) do
    # We've reached the the maximum value in current division
    # 62 62 62
    acc ++ [1]
  end
  defp increment_list([head | tail], acc) do
    result = head + 1

    case result <= radix() do
      true -> Enum.reverse(acc) ++ [result] ++ tail
      false ->
        increment_list(tail, [0])
    end
  end
end
