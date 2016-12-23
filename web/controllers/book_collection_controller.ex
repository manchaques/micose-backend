defmodule MicoseBackend.Book_CollectionController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.Book_Collection

  def index(conn, _params) do
    book_collections = Repo.all(Book_Collection)
    render(conn, "index.json", book_collections: book_collections)
  end

  def create(conn, %{"book__collection" => book__collection_params}) do
    changeset = Book_Collection.changeset(%Book_Collection{}, book__collection_params)

    case Repo.insert(changeset) do
      {:ok, book__collection} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", book__collection_path(conn, :show, book__collection))
        |> render("show.json", book__collection: book__collection)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book__collection = Repo.get!(Book_Collection, id)
    render(conn, "show.json", book__collection: book__collection)
  end

  def update(conn, %{"id" => id, "book__collection" => book__collection_params}) do
    book__collection = Repo.get!(Book_Collection, id)
    changeset = Book_Collection.changeset(book__collection, book__collection_params)

    case Repo.update(changeset) do
      {:ok, book__collection} ->
        render(conn, "show.json", book__collection: book__collection)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book__collection = Repo.get!(Book_Collection, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(book__collection)

    send_resp(conn, :no_content, "")
  end
end
