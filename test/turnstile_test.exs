defmodule TurnstileTest do
  use ExUnit.Case
  doctest Turnstile

  test "greets the world" do
    assert Turnstile.hello() == :world
  end
end
