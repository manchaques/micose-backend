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
      owner: book.owner,
      borrower: book.borrower}
  end
end
