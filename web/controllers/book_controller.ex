defmodule MicoseBackend.BookController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.Book

  def _preloadAll(book) do
    Repo.preload(book, [:owner, :borrower, :classification, :tags])
  end

  def index(conn, _params) do
    books = Book |> Repo.all |> _preloadAll
    render(conn, "index.json", books: books)
  end

  def create(conn, %{"book" => book_params}) do
    changeset = Book.changeset(%Book{}, book_params)

    case Repo.insert(changeset) do
      {:ok, book} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", book_path(conn, :show, book))
        |> render("show.json", book: book)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Repo.get!(Book, id) |> _preloadAll
    render(conn, "show.json", book: book)
  end

  def find(conn, _params) do
    # Create a query
    # query = from p in Book,
    #          join: t in Tag, where: c.post_id == p.id

    # Extend the query
    # query = from [p, c] in query,
    #          select: {p.title, c.body}

    books = Book |> Repo.all |> _preloadAll
    render(conn, "index.json", books: books)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Repo.get!(Book, id)
    changeset = Book.changeset(book, book_params)

    case Repo.update(changeset) do
      {:ok, book} ->
        render(conn, "show.json", book: book)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Repo.get!(Book, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(book)

    send_resp(conn, :no_content, "")
  end
end
