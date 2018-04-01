defmodule CheckpandaServer.UserTest do
  use CheckpandaServer.ModelCase

  alias CheckpandaServer.{Repo, User, Group}

  @valid_attrs %{
    api_token: "7C2C6218-FB50-4D23-9C6D-37434A4F8921",
    line_id: "1234567890",
    line_token: "dummy_token_hogehogefugafugafoobar",
    name: "Test Taro",
    screen_name: "test_taro"
  }

  def make_changeset(params \\ []) do
    params = params
    |> Enum.reduce(@valid_attrs, fn {key, value}, user -> put_in(user, [key], value) end)
    User.changeset(%User{}, params)
  end

  test "changeset with valid attributes" do
    changeset = make_changeset()
    assert changeset.valid?
  end

  test "changeset with screen_name that is too short" do
    changeset = make_changeset(screen_name: "xyz")
    refute changeset.valid?
  end

  test "changeset with screen_name that is too long" do
    changeset = make_changeset(screen_name: "thisisaveryveryveryveryveryverylongname")
    refute changeset.valid?
  end

  test "changeset with screen_name that contains invalid characters" do
    changeset = make_changeset(screen_name: "!!!Tanaka!!!")
    refute changeset.valid?
  end

  test "changeset with screen_name that contains unicode characters" do
    changeset = make_changeset(screen_name: "日本語太郎")
    refute changeset.valid?
  end

  test "changeset with empty name" do
    changeset = make_changeset(name: "")
    refute changeset.valid?
  end

  test "changeset with name that is too long" do
    changeset = make_changeset(
      name: "寿限無寿限無五劫の擦り切れ海砂利水魚の水行末雲来松風来末食う寝る処に住む処")
    refute changeset.valid?
  end

  test "changeset with unicode name" do
    changeset = make_changeset(name: "日本語　太郎")
    assert changeset.valid?
  end

  test "changeset with name that contains ascii symbols" do
    changeset = make_changeset(name: "!!!taro!!!")
    assert changeset.valid?
  end

  test "changeset with name that contains unicode symbols" do
    changeset = make_changeset(name: "田中☆太郎")
    assert changeset.valid?
  end

  test "changeset with name that contains emojis" do
    changeset = make_changeset(name: "田中🍅太郎")
    assert changeset.valid?
  end

  # 注意: Unicodeには\sで判定できない空白文字っぽいものがあり、
  # それらを完全に判定できるわけではない
  test "changeset with name that consists of only spaces" do
    changeset = make_changeset(name: " \t\n　")
    refute changeset.valid?
  end

  test "changeset with api_token that is not UUID" do
    changeset = make_changeset(api_token: "1234abcd5678efgh")
    refute changeset.valid?
  end

  test "create new user" do
    assert {:ok, user} = User.create_user(@valid_attrs)
    assert user.id == user.personal_group.owner_id
  end
end
