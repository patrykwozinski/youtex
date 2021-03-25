defmodule Youtex.MixProject do
  use Mix.Project

  def project do
    [
      app: :youtex,
      version: "0.2.0",
      name: "YouTex",
      description: "Read and filters transcriptions directly from YouTube channels",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      dialyzer: [
        plt_add_deps: :apps_direct,
        plt_add_apps: [],
        plt_ignore_apps: [:logger]
      ]
    ]
  end

  def application do
    [
      applications: [:elixir_xml_to_map],
      extra_applications: [:logger, :poison, :httpoison, :typed_struct]
    ]
  end

  defp deps do
    [
      {:elixir_xml_to_map, "~> 2.0"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.8"},
      {:typed_struct, "~> 0.2"},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/patrykwozinski/youtex"}
    ]
  end
end
