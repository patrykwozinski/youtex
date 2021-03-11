defmodule Youtex.MixProject do
  use Mix.Project

  def project do
    [
      app: :youtex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:elixir_xml_to_map],
      extra_applications: [:logger, :poison, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_xml_to_map, "~> 2.0"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.8"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
