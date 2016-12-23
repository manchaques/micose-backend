defmodule MicoseBackend.MangaView do
  use MicoseBackend.Web, :view

  def render("index.json", %{mangas: mangas}) do
    %{data: render_many(mangas, MicoseBackend.MangaView, "manga.json")}
  end

  def render("show.json", %{manga: manga}) do
    %{data: render_one(manga, MicoseBackend.MangaView, "manga.json")}
  end

  def render("manga.json", %{manga: manga}) do
    %{id: manga.id,
      collection: manga.collection,
      serie: manga.serie,
      title: manga.title,
      tome: manga.tome,
      book: render_one(manga.book, MicoseBackend.BookView, "forTag.json")}
  end
end
