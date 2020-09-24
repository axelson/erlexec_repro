defmodule ErlexecReproTest do
  use ExUnit.Case
  doctest ErlexecRepro

  test "greets the world" do
    assert ErlexecRepro.hello() == :world
  end
end
