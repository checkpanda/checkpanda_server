defmodule CheckpandaServer.Repo.Migrations.UsersNotNull do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :screen_name, :string, null: false
      modify :name, :string, null: false
      modify :line_id, :string, null: false
      modify :line_token, :string, null: false
      modify :api_token, :string, null: false
    end
  end
end
