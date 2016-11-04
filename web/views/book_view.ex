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
      owner: render_one(book.owner, MicoseBackend.UserView, "user.json"),
      borrower: render_one(book.borrower, MicoseBackend.UserView, "user.json"),
      classification: render_one(book.classification, MicoseBackend.ClassificationView, "classification.json"),
      tags: render_many(book.tags, MicoseBackend.TagView, "tag.json"),
      cover_url: book.cover_url,
      creationDate: book.inserted_at,
      updateDate: book.updated_at}
  end
end
