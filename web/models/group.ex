defmodule CheckpandaServer.Group do
  use CheckpandaServer.Web, :model
  alias CheckpandaServer.{Repo, User, Group}

  schema "groups" do
    field(:name, :string)
    field(:is_personal, :boolean, default: false)
    belongs_to(:owner, User, foreign_key: :owner_id)

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :is_personal])
    |> put_assoc(:owner, params.owner)
    |> validate_required([:name, :is_personal])
  end

  def create_private(user) do
    group_set = changeset(%Group{}, %{is_personal: true, owner: user, name: user.name})
    with {:ok, group} <- Repo.insert(group_set)
      do {:ok, group}
      else
        {:error, %{errors: reason}} ->
          {:error, {:unknown_error, reason}}
    end
  end
end
