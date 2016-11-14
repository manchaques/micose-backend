defmodule MicoseBackend.TagView do
  use MicoseBackend.Web, :view

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, MicoseBackend.TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, MicoseBackend.TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      name: tag.name,
      books: render_many(tag.books, MicoseBackend.BookView, "forTag.json")
    }
  end

  def render("tagName.json", %{tag: tag}) do
    %{name: tag.name}
  end

end
