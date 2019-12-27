#
#  config.ex
#  turnstile
# 
#  Created by Wess Cope (me@wess.io) on 12/27/19
#  Copyright 2019 Wess Cope
#

defmodule Turnstile.Config do

  def definition do
    Application.get_env(:turnstile, :definition, "turnstile.yml")
  end

  def port do
    Application.get_env(:turnstile, :port, 3000)
  end

  def compress do
    Application.get_env(:turnstile, :enable_compression, true)
  end

  def table do
    Application.get_env(:turnstile, :ets_table, "_turnstile_ets")
  end


  def not_found do
    Application.get_env(:turnstile, :not_found, "The request resource was not found")
  end 
end
