defmodule CheckpandaServer.GroupView do
  use CheckpandaServer.Web, :view

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, CheckpandaServer.GroupView, "group.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, CheckpandaServer.GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{id: group.id,
      name: group.name,
      is_personal: group.is_personal,
      owner_id: group.owner_id}
  end
end
