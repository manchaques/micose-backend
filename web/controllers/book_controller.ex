defmodule MicoseBackend.BookController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.Book

  import Ecto.Query, only: [from: 2]

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

  def find(conn, %{"tag" => tag}) do
    # Create a query
    # example : http://localhost:4000/api/book/find/?tag=Vertigo
    queryTag = from b in Book,
              join: bt in MicoseBackend.Books_tags, on: bt.book_id == b.id,
              inner_join: t in MicoseBackend.Tag, on: bt.tag_id == t.id,
              select: b,
              where: t.name == ^tag or b.title == ^tag or b.subtitle == ^tag;

    #title #subtitle
    books = Repo.all(queryTag) |> _preloadAll;
    render(conn, "index.json", books: books)
  end

  def find(conn, %{"community" => community}) do
    # Create a query
    # example : http://localhost:4000/api/book/find/?tag=Vertigo
    queryTag = from b in Book,
              inner_join: u in MicoseBackend.User, on: u.id == b.owner_id,
              join: uc in MicoseBackend.Users_Communities, on: uc.user_id == u.id,
              inner_join: c in MicoseBackend.Community, on: uc.community_id == c.id,
              select: b,
              where: c.name == ^community;

    #title #subtitle
    books = Repo.all(queryTag) |> _preloadAll;
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
