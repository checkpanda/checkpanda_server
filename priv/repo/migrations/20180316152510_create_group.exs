defmodule CheckpandaServer.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :is_personal, :boolean, default: false, null: false
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:groups, [:owner_id])

  end
end
