defmodule KVTest do
  use ExUnit.Case
  doctest KV

  test "greets the world" do
    assert KV.hello() == :world
  end
  test "greets the world by keyur" do
    assert KV.hello() == :world
  end

end
