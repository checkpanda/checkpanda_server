defmodule CheckpandaServer.Repo.Migrations.RemoveJunctionIds do
  use Ecto.Migration

  def change do
    drop table(:groups_users)

    create table(:groups_users, primary_key: false) do
      add :group_id, references(:groups, on_delete: :delete_all),
        null: false, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all),
        null: false, primary_key: true
    end

    drop table(:todos_assignees)

    create table(:todos_assignees, primary_key: false) do
      add :todo_id, references(:todos, on_delete: :delete_all),
        null: false, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all),
        null: false, primary_key: true
    end
  end
end
