#
#  output.ex
#  cli
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.CLI.Console do
  alias Turnstile.CLI.Style

  def success(msg) do
    msg
    |> Style.green
    |> info
  end

  def error(msg) do
    msg
    |> Style.red
    |> info
  end

  def info(msg) do
    msg
    |> IO.puts
  end
end
