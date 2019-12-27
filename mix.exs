#
#  mix.exs
#  turnstile
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.MixProject do
  use Mix.Project

  @version File.read!("VERSION") |> String.trim()

  def project do
    [
      app:              :turnstile,
      version:          @version,
      elixir:           "~> 1.9",
      start_permanent:  Mix.env() == :prod,
      description:      description(),
      package:          package(),
      deps:             deps(),
      escript:          [main_module: Turnstile.CLI]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Turnstile.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla,        "~> 1.3.0"},
      {:jason,        "~> 1.1"},
      {:cowboy,       "~> 2.7"},
      {:plug_cowboy,  "~> 2.0"},
      {:yaml_elixir,  "~> 2.4"},
      {:ex_cli,       "~> 0.1.0"}
    ]
  end

  defp description do
    "Simplified API Gateway powered by Elixir."
  end

  defp package do
    [
      name:         :turnstile,
      files:        ~w(mix.exs lib README.md LICENSE VERSION),
      maintainers:  ["Wess Cope <me@wess.io>"],
      licenses:     ["MIT"],
      links:        %{github: "https://github.com/wess/turnstile"}
    ]
  end
end
