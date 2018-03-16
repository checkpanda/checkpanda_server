defmodule CheckpandaServer.Repo.Migrations.GroupsUsers do
  use Ecto.Migration

  def change do
    create table(:groups_privileges) do
      add :name, :string, null: false
    end

    create table(:groups_users) do
      add :group_id, references(:groups, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :privilege, references(:groups_privileges, on_delete: :nilify_all)
    end
  end
end
