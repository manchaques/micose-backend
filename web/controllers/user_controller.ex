defmodule MicoseBackend.UserController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.User

  def _preloadAll(user) do
    user
    |> Repo.preload([:communities])
    |> Repo.preload([{:books, [:borrower, :classification, :tags]}])
    |> Repo.preload([{:borrowed_books, [:owner, :classification, :tags]}])
  end

  def index(conn, _params) do
    users = User |> Repo.all |> _preloadAll
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id) |> _preloadAll
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end

  def find(conn, %{"techName" => techName}) do
    user = Repo.get_by(User, techName: techName) |> _preloadAll;
    render(conn, "show.json", user: user)
  end

  def find(conn, %{"community" => community}) do
      query = from u in User,
              join: uc in MicoseBackend.Users_Communities, on: uc.user_id == u.id,
              select: u,
              where: uc.community_id == ^community;

      users = Repo.all(query) |> _preloadAll;
      render(conn, "index.json", users: users)
    end
end
