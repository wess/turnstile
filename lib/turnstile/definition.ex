#
#  definition.ex
#  turnstile
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Definition do
  require Logger

  alias Turnstile.Config
  alias Turnstile.CLI.Console
  
  def read(path) do
    case YamlElixir.read_from_file(path) do
      {:ok, res} ->
        res
      {:error, _err} ->
        Console.error("Unable to load definition file at #{path}")
        System.halt(1)
    end
  end

  def read do
    read(Config.definition)
  end

  def verify_mounts(definition) do
    unless Map.has_key?(definition, "mount") do
      Console.error("No mount points found in definition")
      System.halt(1)
    end

    definition
  end

  def verify_version(definition) do
    unless Map.has_key?(definition, "version") do
      Console.error("No version was defined in definition")
      System.halt(1)
    end

    definition
  end

  def load(path) do
    path
    |> read()
    |> verify_version()
    |> verify_mounts()
  end
end
