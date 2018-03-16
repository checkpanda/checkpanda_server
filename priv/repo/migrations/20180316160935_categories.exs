defmodule CheckpandaServer.Repo.Migrations.Categories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :group_id, references(:groups, on_delete: :delete_all), null: false
      add :name, :string, null: false
    end
  end
end
