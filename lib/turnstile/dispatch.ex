#
#  dispatch.ex
#  turnstile
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Dispatch do
  require Logger
  
  alias Turnstile.Actions.HTTP

  def init(opts), do: opts

  def call(conn, _) do
    table = String.to_atom(Turnstile.Config.table)

    case :ets.match_object(table, {conn.request_path, conn.method, :"$3"}) do
      [{_path, _method, opts}] ->
        conn
        |> HTTP.receive(opts)
      [] ->
        conn
        |> HTTP.not_found()
    end
  end

end
