# LexorankEx

[![Module Version](https://img.shields.io/hexpm/v/lexorank_ex)](https://hex.pm/packages/lexorank_ex/0.1.5)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/lexorank_ex/0.1.5/LexorankEx.html)

LexoRank on Elixir. An implementation of a list ordering system.

The base62: (0-9A-Za-z) pre-generated symbol table are used
where minimum value is 0 and maximum value is z

## Installation

The package can be installed by adding `lexorank_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:lexorank_ex, "~> 0.1.5"}
  ]
end
```


## Usage

```elixir
# Generates middle string between max and min value for provided division

divison = 8
LexorankEx.middle(divison) => "Uzzzzzzz"

# Default step is 8

# Finds next, lexically greater value:

LexorankEx.next("00000") == "00008"
LexorankEx.next("00000", 1) == "00001"

LexorankEx.next("a") == "i"
LexorankEx.next("a", 1) == "b"

# Finds previous, lexically lesser value:

LexorankEx.prev("00008") == "00000"
LexorankEx.prev("00008", 1) == "00007"

LexorankEx.prev("i") == "a"
LexorankEx.prev("b", 1) == "a"

# Finds middle point between maximum and minimum value. Order doesn't matter:
LexorankEx.between("a", "b") == "aV"
LexorankEx.between("a", "c") == "b"
LexorankEx.between("aaaaz", "zzzzz") == "nIIIU"


# Finds the distance between two values

LexorankEx.distance("V0000007", "V000000F") == 8
LexorankEx.distance("00", "zz") == 3843
LexorankEx.distance("aa", "bb") == 63
LexorankEx.distance("00", "010") == 62
LexorankEx.distance("a0", "b") == 62
LexorankEx.distance("a0", "b1") == 63
LexorankEx.distance("a", "b") == 1
```

# Buckets

Usually all ranks are unique. But if you need to rebalance your set, Buckets will help you.
Bucket API is the same, but for all generated ranks it will add bucket prefix.

```
alias LexorankEx.Bucket

Bucket.middle(8) == "1|Uzzzzzzz"
Bucket.next("1|a") == "1|i"
Bucket.next("1|00000") == "1|00008"
Bucket.prev("3|b0007") == "3|azzzz"
Bucket.between("2|aaaaz", "2|zzzzz") == "2|nIIIT"
Bucket.distance("1|00", "1|010") == 62

Bucket.new("1|00000") == "2|00000"
Bucket.new("2|00000") == "3|00000"
Bucket.new("3|00000") == "1|00000"

Bucket.new("3|00000", :middle) == "1|Uzzzzzzz"
```

## References

Thanks to the [mudderjs](https://github.com/fasiha/mudderjs) and its explanation of the algorithm

