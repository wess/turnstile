#
#  cli.ex
#  turnstile
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.CLI do
  require Logger
  use ExCLI.DSL, escript: true

  name        "turnstile"
  description "Turnstile commandline interface"

  long_description ~s"""
  Commandline interface for working with Turnstile API gateway.
  """


  command :run do
  end

  command :version do
    Logger.info(fn-> "Turnstile version #{Turnstile.version}" end)
  end

  command :new do
  end
end

# defmodule Farseer.Cli do
#   def main(args \\ []) do
#     command = Enum.at(args, 0)

#     cond do
#       command == "run" -> Farseer.Server.start(1, 2)
#       command == "version" -> Farseer.Cli.version()
#       command == "help" -> Farseer.Cli.help()
#       command == nil -> Farseer.Cli.help()
#       true -> Farseer.Cli.help()
#     end
#   end

#   def version() do
#     IO.puts("Farseer version #{Application.spec(:farseer, :vsn)}")
#   end

#   def help do
#   end
# end
