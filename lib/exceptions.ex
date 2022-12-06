defmodule LexorankEx.Error do
  defexception message: "Something bad happened."
end

defmodule LexorankEx.MaxValueReachedError do
  defexception message:
                 "There is no space to grow. Generated value is lexically smaller than provied rank"
end

defmodule LexorankEx.MinValueReachedError do
  defexception message:
                 "Provided Rank is a minimum. Generated value is lexically greater than provied rank"
end

defmodule LexorankEx.Bucket.MismatchError do
  defexception message: "Provided ranks are from different buckets"
end
