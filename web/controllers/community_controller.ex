defmodule MicoseBackend.CommunityController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.Community
  alias MicoseBackend.Users_Communities

  def _preloadAll(community) do
    Repo.preload(community, [:users])
  end

  def index(conn, _params) do
    communities = Community |> Repo.all |> _preloadAll
    render(conn, "index.json", communities: communities)
  end

  def create(conn, %{"community" => community_params}) do
    changeset = Community.changeset(%Community{}, community_params)

    case Repo.insert(changeset) do
      {:ok, community} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", community_path(conn, :show, community))
        |> render("show.json", community: community)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    community = Repo.get!(Community, id) |> _preloadAll
    render(conn, "show.json", community: community)
  end

  def update(conn, %{"id" => id, "community" => community_params}) do
    community = Repo.get!(Community, id)
    changeset = Community.changeset(community, community_params)

    case Repo.update(changeset) do
      {:ok, community} ->
        render(conn, "show.json", community: community)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    community = Repo.get!(Community, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(community)

    send_resp(conn, :no_content, "")
  end

  def join(conn, %{"community_id" => community_id, "user_id" => user_id} = params) do
    changeset = Users_Communities.changeset(%Users_Communities{}, params)

    case Repo.insert(changeset) do
      {:ok, user_community} ->
        conn
        |> put_status(:created)
        |> json(%{community_id: community_id, user_id: user_id})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
