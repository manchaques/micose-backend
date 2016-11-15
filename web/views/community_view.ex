defmodule MicoseBackend.CommunityView do
  use MicoseBackend.Web, :view

  def render("index.json", %{communities: communities}) do
    %{data: render_many(communities, MicoseBackend.CommunityView, "community.json")}
  end

  def render("show.json", %{community: community}) do
    %{data: render_one(community, MicoseBackend.CommunityView, "community.json")}
  end

  def render("community.json", %{community: community}) do
    %{id: community.id,
      name: community.name}
  end
end
