defmodule CheckpandaServer.Repo.Migrations.UsersIndices do
  use Ecto.Migration

  def change do
    create index(:users, [:screen_name], [])
    create index(:users, [:line_id], [])
    create index(:users, [:api_token], [])
  end
end
