#
#  http.ex
#  actions
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Actions.HTTP do
  require Logger

  alias Plug.Conn
  alias Turnstile.Http.Headers
  alias Turnstile.Config
  alias Turnstile.Actions.HTTP

  @not_found %{
    text: Config.not_found,
    json: %{error: Config.not_found},
    html: ~s"""
    <!doctype html>
    <html>
      <head>
      </head>
      <body>
        #{Config.not_found}
      </body>
    </html>
    """
  }

  def accepts?(conn, mime) do
    type =
      mime
      |> String.split("/")
      |> List.first()

    conn
    |> Conn.get_req_header("accept")
    |> List.first()
    |> String.contains?(["*/*", "#{type}/*", mime])
  end

  def respond(conn, status, body, content_type \\ "text/plain") do
    conn
    |> Conn.put_resp_content_type(content_type)
    |> Conn.send_resp(status, body)
  end

  def send(conn, options) do
    headers =
      conn.req_headers
      |> Headers.filter()
      |> Headers.add(options["request_headers"])

    options["to"]
    |> Tesla.get!(headers: headers)
  end
  
  def receive(conn, to) do
    res = HTTP.send(conn, to)

    conn
    |> Headers.update_conn(res.headers)
    |> Conn.send_resp(res.status, res.body)
  end

  def not_found(conn) do
    cond do
      Turnstile.Actions.HTTP.accepts?(conn, "application/json") ->
        conn
        |> Turnstile.Actions.HTTP.respond(404, Jason.encode!(@not_found[:json]), "application/json")

      Turnstile.Actions.HTTP.accepts?(conn, "text/html") ->
        conn
        |> Turnstile.Actions.HTTP.respond(404, @not_found[:html], "text/html")

      true ->
        conn
        |> Turnstile.Actions.HTTP.respond(404, @not_found[:text])
        
    end
  end
end
