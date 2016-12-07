defmodule MicoseBackend.ComicsController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.Comics

  def index(conn, _params) do
    comics = Repo.all(Comics)
    render(conn, "index.json", comics: comics)
  end

  def create(conn, %{"comics" => comics_params}) do
    changeset = Comics.changeset(%Comics{}, comics_params)

    case Repo.insert(changeset) do
      {:ok, comics} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", comics_path(conn, :show, comics))
        |> render("show.json", comics: comics)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comics = Repo.get!(Comics, id)
    render(conn, "show.json", comics: comics)
  end

  def update(conn, %{"id" => id, "comics" => comics_params}) do
    comics = Repo.get!(Comics, id)
    changeset = Comics.changeset(comics, comics_params)

    case Repo.update(changeset) do
      {:ok, comics} ->
        render(conn, "show.json", comics: comics)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comics = Repo.get!(Comics, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comics)

    send_resp(conn, :no_content, "")
  end
end
