defmodule CheckpandaServer.User do
  use CheckpandaServer.Web, :model

  schema "users" do
    field :screen_name, :string, null: false
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
  end
end
