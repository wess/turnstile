#
#  application.ex
#  turnstile
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Application do
  require Logger
  use Application

  def start(_type, _args) do
    Turnstile.Mount.init()

    children = [
      {
        Plug.Cowboy, 
        scheme:   :http,
        plug:     Turnstile.Http.Router, 
        options:  [
          port:     Turnstile.Config.port,
          compress: Turnstile.Config.compress
        ]
      }
    ]

    Logger.info(fn-> "Turnstile running on port #{Turnstile.Config.port}" end)

    opts = [strategy: :one_for_one, name: Turnstile.Supervisor]
    Supervisor.start_link(children, opts)


    # Turnstile.run()
  end
end
