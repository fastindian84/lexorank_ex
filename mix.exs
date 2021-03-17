defmodule LexorankEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :lexorank_ex,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description() do
    "LexoRank on Elixir. An implementation of a list ordering system."
  end

  defp package() do
    [
      name: "lexorank_ex",
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Yaroslav Senishyn"],
      # These are the default files included in the package
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/fastindian84/lexorank_ex"},
      docs: [
        main: "LexorankEx", # The main page in the docs
        extras: ["README.md"]
      ]
    ]
  end
end
