defmodule CheckpandaServer.GroupTest do
  use CheckpandaServer.ModelCase

  alias CheckpandaServer.Group

  @valid_attrs %{is_personal: true, name: "some content", owner: nil}
  @invalid_attrs %{owner: nil}

  test "changeset with valid attributes" do
    changeset = Group.changeset(%Group{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Group.changeset(%Group{}, @invalid_attrs)
    refute changeset.valid?
  end
end
