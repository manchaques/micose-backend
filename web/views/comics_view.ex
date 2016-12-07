defmodule MicoseBackend.ComicsView do
  use MicoseBackend.Web, :view

  def render("index.json", %{comics: comics}) do
    %{data: render_many(comics, MicoseBackend.ComicsView, "comics.json")}
  end

  def render("show.json", %{comics: comics}) do
    %{data: render_one(comics, MicoseBackend.ComicsView, "comics.json")}
  end

  def render("comics.json", %{comics: comics}) do
    %{id: comics.id,
      collection: comics.collection,
      serie: comics.serie,
      title: comics.title,
      tome: comics.tome,
      book_id: comics.book_id}
  end
end
