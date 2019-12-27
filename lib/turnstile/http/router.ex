#
#  router.ex
#  http
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Http.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/_v" do
    conn
    |> send_resp(200, Turnstile.version)
  end

  forward "/", to: Turnstile.Dispatch
end
