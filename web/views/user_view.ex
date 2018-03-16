defmodule CheckpandaServer.UserView do
  use CheckpandaServer.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, CheckpandaServer.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, CheckpandaServer.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      screen_name: user.screen_name,
      name: user.name,
      line_id: user.line_id,
      line_token: user.line_token,
      api_token: user.api_token}
  end
end
