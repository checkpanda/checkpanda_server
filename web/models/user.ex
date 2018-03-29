defmodule CheckpandaServer.User do
  use CheckpandaServer.Web, :model
  alias CheckpandaServer.{Repo, User, Group}

  @screen_name_length_min Application.get_env(:checkpanda_server, :screen_name_length_min)
  @screen_name_length_max Application.get_env(:checkpanda_server, :screen_name_length_max)
  @screen_name_format Application.get_env(:checkpanda_server, :screen_name_format)
  @name_length_min Application.get_env(:checkpanda_server, :name_length_min)
  @name_length_max Application.get_env(:checkpanda_server, :name_length_max)
  @name_format Application.get_env(:checkpanda_server, :name_format)
  @api_token_length Application.get_env(:checkpanda_server, :api_token_length)
  @line_id_length_min Application.get_env(:checkpanda_server, :line_id_length_min)
  @line_token_length_min Application.get_env(:checkpanda_server, :line_token_length_min)

  schema "users" do
    field(:screen_name, :string, null: false, unique: true)
    field(:name, :string, null: false)
    field(:line_id, :string, null: false)
    field(:line_token, :string, null: false)
    field(:api_token, :string, null: false)

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:screen_name, :name, :line_id, :line_token, :api_token])
    |> validate_required([:screen_name, :name, :line_id, :line_token, :api_token])
    |> validate_length(
      :screen_name,
      min: @screen_name_length_min,
      max: @screen_name_length_max
    )
    |> validate_format(:screen_name, @screen_name_format)
    |> unique_constraint(:screen_name)
    |> validate_length(:name, min: @name_length_min, max: @name_length_max)
    |> validate_format(:name, @name_format)
    |> validate_length(:api_token, is: @api_token_length)
    |> validate_length(:line_id, min: @line_id_length_min)
    |> validate_length(:line_token, min: @line_token_length_min)
  end

  @doc """
  新たなユーザーと、そのユーザーの所有するプライベートなグルー
  プを作成する。ただし、ユーザーの LINE ID, LINE Access Token は正しい
  ものであるという前提である。
  """
  def create_user(params) do
    with {:ok, result} <- Repo.transaction(
           fn ->
             with user_set <- changeset(%User{}, params),
                  {:ok, user} <- Repo.insert(user_set),
                  {:ok, group} <- Group.create_private(user)
               do {:ok, user, group}
               else
                 {:error, %{errors: [{:screen_name, {"has already been taken", _}} | _]}} ->
                   {:error, :screen_name_already_taken}
                 {:error, %{errors: [{key, {"is invalid", _}} | _]}} ->
                   {:error, {:invalid_parameter, key}}
                 {:error, %{errors: reason}} ->
                   {:error, {:unknown_error, reason}}
                 {:error, reason} -> {:error, reason}
                  end
           end)
      do result
      else {:error, reason} ->
          {:error, reason}
    end
  end
end
