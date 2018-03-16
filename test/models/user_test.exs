defmodule CheckpandaServer.UserTest do
  use CheckpandaServer.ModelCase

  alias CheckpandaServer.User

  @valid_attrs %{api_token: "some content", line_id: "some content", line_token: "some content", name: "some content", screen_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
