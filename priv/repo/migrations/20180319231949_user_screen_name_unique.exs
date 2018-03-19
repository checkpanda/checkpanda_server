defmodule CheckpandaServer.Repo.Migrations.UserScreenNameUnique do
  use Ecto.Migration

  def change do
    drop index(:users, [:screen_name])
    create unique_index(:users, [:screen_name])
  end

end
