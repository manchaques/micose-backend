defmodule MicoseBackend.ClassificationView do
  use MicoseBackend.Web, :view

  def render("index.json", %{classifications: classifications}) do
    %{data: render_many(classifications, MicoseBackend.ClassificationView, "classification.json")}
  end

  def render("show.json", %{classification: classification}) do
    %{data: render_one(classification, MicoseBackend.ClassificationView, "classification.json")}
  end

  def render("classification.json", %{user: nil}) do
    nil
  end

  def render("classification.json", %{classification: classification}) do
    %{id: classification.id,
      name: classification.name}
  end
end
