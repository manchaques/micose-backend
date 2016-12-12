defmodule MicoseBackend.Book_CollectionView do
  use MicoseBackend.Web, :view

  def render("index.json", %{book_collections: book_collections}) do
    %{data: render_many(book_collections, MicoseBackend.Book_CollectionView, "book__collection.json")}
  end

  def render("show.json", %{book__collection: book__collection}) do
    %{data: render_one(book__collection, MicoseBackend.Book_CollectionView, "book__collection.json")}
  end

  def render("book__collection.json", %{book__collection: book__collection}) do
    %{id: book__collection.id,
      book_id: book__collection.book_id,
      user_id: book__collection.user_id,
      borrower_id: book__collection.borrower_id}
  end
end
