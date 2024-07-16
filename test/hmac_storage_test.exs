defmodule HmacStorageTest do
  use ExUnit.Case
  doctest HmacStorage

  test "greets the world" do
    assert HmacStorage.hello() == :world
  end
end
