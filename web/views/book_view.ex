defmodule MicoseBackend.BookView do
  use MicoseBackend.Web, :view

  def render("index.json", %{books: books}) do
    %{data: render_many(books, MicoseBackend.BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, MicoseBackend.BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{id: book.id,
      title: book.title,
      subtitle: book.subtitle,
      owner: MicoseBackend.UserView.render("user.json", user: book.owner),
      borrower: book.borrower,
      creationDate: book.inserted_at,
      updateDate: book.updated_at}
  end
end
