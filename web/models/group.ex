defmodule CheckpandaServer.Group do
  use CheckpandaServer.Web, :model

  schema "groups" do
    field :name, :string
    field :is_personal, :boolean, default: false
    belongs_to :owner, CheckpandaServer.Owner

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :is_personal])
    |> validate_required([:name, :is_personal])
  end
end
