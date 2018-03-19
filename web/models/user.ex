defmodule CheckpandaServer.User do
  use CheckpandaServer.Web, :model

  @screen_name_length_min Application.get_env(
    :checkpanda_server, :screen_name_length_min)
  @screen_name_length_max Application.get_env(
    :checkpanda_server, :screen_name_length_max)
  @screen_name_format Application.get_env(
    :checkpanda_server, :screen_name_format)
  @name_length_min Application.get_env(
    :checkpanda_server, :name_length_min)
  @name_length_max Application.get_env(
    :checkpanda_server, :name_length_max)
  @name_format Application.get_env(
    :checkpanda_server, :name_format)
  @api_token_length Application.get_env(
    :checkpanda_server, :api_token_length)
  @line_id_length_min Application.get_env(
    :checkpanda_server, :line_id_length_min)
  @line_token_length_min Application.get_env(
    :checkpanda_server, :line_token_length_min)

  schema "users" do
    field :screen_name, :string, null: false, unique: true
    field :name, :string, null: false
    field :line_id, :string, null: false
    field :line_token, :string, null: false
    field :api_token, :string, null: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:screen_name, :name, :line_id, :line_token, :api_token])
    |> validate_required([:screen_name, :name, :line_id, :line_token, :api_token])
    |> validate_length(
      :screen_name, min: @screen_name_length_min, max: @screen_name_length_max
    )
    |> validate_format(:screen_name, @screen_name_format)
    |> unique_constraint(:screen_name)
    |> validate_length(:name, min: @name_length_min, max: @name_length_max)
    |> validate_format(:name, @name_format)
    |> validate_length(:api_token, is: @api_token_length)
    |> validate_length(:line_id, min: @line_id_length_min)
    |> validate_length(:line_token, min: @line_token_length_min)
  end
end
