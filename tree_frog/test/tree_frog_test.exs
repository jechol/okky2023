defmodule TreeFrogTest do
  use ExUnit.Case
  doctest TreeFrog

  test "greets the world" do
    assert TreeFrog.hello() == :world
  end
end
