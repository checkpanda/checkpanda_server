defmodule CheckpandaServer.Repo.Migrations.Todos do
  use Ecto.Migration

  def change do
    create table(:todos_priorities) do
      add :name, :string, null: false
      # 内部的に数値を持たせておくことで、比較可能にする
      add :value, :integer, null: false
    end

    create table(:todos) do
      add :group_id, references(:groups, on_delete: :delete_all), null: false
      add :deadline, :timestamp, null: true
      add :priority_id, references(:todos_priorities, on_delete: :nilify_all), null: true
      add :is_template, :boolean, null: false
      add :memo, :string, null: false
      add :done, :boolean, null: false
    end

    create table(:todos_assignees) do
      add :todo_id, references(:todos, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
    end
  end
end
