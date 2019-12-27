#
#  headers.ex
#  http
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Http.Headers do
  require Logger
  
  def filter(headers) do
    Enum.reject(headers, fn header -> 
      Enum.member?(["host", "accept-encoding", "dnt"], elem(header, 0))
    end)
  end

  def basic_auth(username, password) do
    "Basic " <> Base.encode64("#{username}:#{password}")
  end

  def resolve(header, options) do
    Logger.info(fn-> "resolve opt: #{options}" end)
    cond do
      header == "authorization" ->
        {header, basic_auth(options["username"], options["password"])}
    end

    header
  end

  def add(headers, nil), do: headers

  def add(headers, headers_to_add) do
    Enum.reduce(headers_to_add, headers, fn {key, value}, acc ->
      acc ++ [Headers.resolve(key, value)]
    end)
  end

  def update_conn(conn, headers) do
    headers
    |> Enum.reduce(conn, fn {k,v}, acc -> 
      acc
      |> Plug.Conn.put_resp_header(k, v)
    end)
  end
end
