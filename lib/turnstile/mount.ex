#
#  mounts.ex
#  turnstile
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Mount do
  require Logger

  alias Turnstile.Config
  alias Turnstile.Definition

  @options ["to", "request_headers"]

  def init do
    Config.table
    |> String.to_atom()
    |> :ets.new([:set, :protected, :named_table])

    Turnstile.Mount.list()
    |> Enum.each(fn {_n, mnt} -> Turnstile.Mount.register(mnt) end)

  end

  def list do
    Config.definition
    |> Definition.load()
    |> Map.get("mount")
  end

  def options(mnt) do
    mnt
    |> Enum.reduce(%{}, fn {k, v}, acc -> 
      case Enum.member?(@options, k) do
        true ->
          acc
          |> Map.put(k, v)
        false ->
          acc
      end
    end)
  end

  def register(mnt) do
    opts = Turnstile.Mount.options(mnt)

    case Map.get(mnt, "methods") do
      {methods} ->
        methods
        |> Enum.each(fn m -> 
          Config.table
          |> :ets.insert({mnt["path"], String.upcase(m), opts})
        end)

      _ -> 
        Config.table
        |> String.to_atom
        |> :ets.insert({mnt["path"], "GET", opts})
    end

  end
end
