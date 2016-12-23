defmodule MicoseBackend.MangaTest do
  use MicoseBackend.ModelCase

  alias MicoseBackend.Manga

  @valid_attrs %{collection: "some content", serie: "some content", title: "some content", tome: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Manga.changeset(%Manga{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Manga.changeset(%Manga{}, @invalid_attrs)
    refute changeset.valid?
  end
end
