defmodule CheckpandaServer.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :screen_name, :string
      add :name, :string
      add :line_id, :string
      add :line_token, :string
      add :api_token, :string

      timestamps()
    end

  end
end
