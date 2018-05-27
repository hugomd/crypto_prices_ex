defmodule StatWatchTest do
  use ExUnit.Case
  doctest StatWatch

  test "greets the world" do
    assert StatWatch.hello() == :world
  end
end
