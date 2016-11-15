defmodule MicoseBackend.CommunityView do
  use MicoseBackend.Web, :view

  def render("index.json", %{communities: communities}) do
    %{data: render_many(communities, MicoseBackend.CommunityView, "communityEnriched.json")}
  end

  def render("show.json", %{community: community}) do
    %{data: render_one(community, MicoseBackend.CommunityView, "communityEnriched.json")}
  end

  def render("community.json", %{community: community}) do
    %{id: community.id,
      name: community.name}
  end

  def render("communityEnriched.json", %{community: community}) do
      %{id: community.id,
        name: community.name,
        users: render_many(community.users, MicoseBackend.UserView, "userLight.json")}
    end
end
