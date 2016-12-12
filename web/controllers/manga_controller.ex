defmodule MicoseBackend.MangaController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.Manga

  def index(conn, _params) do
    mangas = Repo.all(Manga)
    render(conn, "index.json", mangas: mangas)
  end

  def create(conn, %{"manga" => manga_params}) do
    changeset = Manga.changeset(%Manga{}, manga_params)

    case Repo.insert(changeset) do
      {:ok, manga} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", manga_path(conn, :show, manga))
        |> render("show.json", manga: manga)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    manga = Repo.get!(Manga, id)
    render(conn, "show.json", manga: manga)
  end

  def update(conn, %{"id" => id, "manga" => manga_params}) do
    manga = Repo.get!(Manga, id)
    changeset = Manga.changeset(manga, manga_params)

    case Repo.update(changeset) do
      {:ok, manga} ->
        render(conn, "show.json", manga: manga)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    manga = Repo.get!(Manga, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(manga)

    send_resp(conn, :no_content, "")
  end
end
